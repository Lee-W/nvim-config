-- Review the whole branch against wherever it forked from. In a fork workflow
-- origin is your own fork, so upstream is the honest baseline; fall further back
-- because plenty of clones never resolve a remote HEAD.
local function diffview_branch()
  local function exists(ref) return vim.system({ "git", "rev-parse", "--verify", "--quiet", ref }):wait().code == 0 end
  -- --imply-local points the HEAD side at the real files rather than blobs read
  -- out of git, which keeps LSP working and lets fixes happen in the diff itself
  for _, ref in ipairs({ "upstream/HEAD", "origin/HEAD", "origin/main", "origin/master" }) do
    if exists(ref) then
      return vim.cmd("DiffviewOpen " .. ref .. "...HEAD --imply-local")
    end
  end
  vim.notify("Diffview: no remote base found, diffing against HEAD~1", vim.log.levels.WARN)
  vim.cmd("DiffviewOpen HEAD~1...HEAD --imply-local")
end

-- Diff exactly what GitHub shows for the checked-out PR: its real base (not a
-- guessed default branch), at the base's current tip, merge-base style. Stale
-- remote refs are the usual reason a local diff disagrees with the PR page.
local function diffview_pr()
  local cwd = vim.fn.getcwd()
  local command_timeout_ms = 30000
  local function warn(message) vim.notify("Diffview: " .. message, vim.log.levels.WARN) end
  local function failure(cmd, result)
    local detail = result.code == 124 and "timed out" or vim.trim(result.stderr or "")
    return table.concat(cmd, " ") .. ": " .. (detail ~= "" and detail or "exit " .. result.code)
  end
  local function run(cmd, callback)
    -- Schedule process completion before using Neovim APIs.
    callback = vim.schedule_wrap(callback)
    local ok, err = pcall(vim.system, cmd, { text = true, cwd = cwd, timeout = command_timeout_ms }, callback)
    if not ok then
      callback({ code = -1, stdout = "", stderr = tostring(err) })
    end
  end

  local query = { "gh", "pr", "view", "--json", "baseRefName,baseRefOid" }
  run(query, function(view)
    if view.code ~= 0 then
      return warn(failure(query, view))
    end
    local ok, pr = pcall(vim.json.decode, view.stdout)
    if
      not ok
      or type(pr) ~= "table"
      or type(pr.baseRefName) ~= "string"
      or pr.baseRefName == ""
      or type(pr.baseRefOid) ~= "string"
      or not pr.baseRefOid:match("^%x+$")
    then
      return warn("gh pr view returned invalid PR base data")
    end

    -- A successful fetch may come from an outdated fork. Verify the exact SHA
    -- after each attempt, and keep trying until that commit is available.
    local remotes, errors = { "upstream", "origin" }, {}
    local function open_or_fetch(index)
      run({ "git", "cat-file", "-e", pr.baseRefOid .. "^{commit}" }, function(result)
        if result.code == 0 then
          return require("diffview").open({ "-C=" .. cwd, pr.baseRefOid .. "...HEAD", "--imply-local" })
        end
        local remote = remotes[index]
        if not remote then
          return warn("PR base commit is unavailable: " .. pr.baseRefOid .. "\n" .. table.concat(errors, "\n"))
        end
        local fetch = { "git", "fetch", remote, pr.baseRefName }
        run(fetch, function(fetched)
          if fetched.code ~= 0 then
            errors[#errors + 1] = failure(fetch, fetched)
          end
          open_or_fetch(index + 1)
        end)
      end)
    end
    open_or_fetch(1)
  end)
end

return {
  {
    -- lazyvim default; add lightweight inline current-line blame
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      opts.current_line_blame = true
      opts.current_line_blame_opts = { delay = 500 }

      -- ]c / [c are Vim's diff-mode motions and do nothing outside a diff
      -- window; fall back to gitsigns hunks there so one key means "next
      -- change" everywhere. Wrap rather than replace LazyVim's on_attach,
      -- which owns ]h, [h and the whole <leader>gh group.
      local lazyvim_on_attach = opts.on_attach
      opts.on_attach = function(buffer)
        if lazyvim_on_attach then
          lazyvim_on_attach(buffer)
        end

        local function map(lhs, direction, desc)
          vim.keymap.set("n", lhs, function()
            if vim.wo.diff then
              -- bang skips mappings; without it this recurses into itself
              vim.cmd.normal({ lhs, bang = true })
            else
              package.loaded.gitsigns.nav_hunk(direction)
            end
          end, { buffer = buffer, desc = desc, silent = true })
        end

        map("]c", "next", "Next Change")
        map("[c", "prev", "Prev Change")
      end
    end,
  },
  {
    -- git wrapper
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gbrowse",
      "Gdiffsplit",
      "Gedit",
      "Ggrep",
      "Gread",
      "Gvdiffsplit",
      "Gwrite",
      "GDelete",
      "GMove",
      "GRename",
    },
  },
  {
    -- conflict resolver (lua-native: co/ct/cb/c0, ]x/[x to navigate)
    "akinsho/git-conflict.nvim",
    version = "*",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
  {
    -- :DiffView.*
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewClose",
      "DiffviewFileHistory",
      "DiffviewFocusFiles",
      "DiffviewLog",
      "DiffviewOpen",
      "DiffviewRefresh",
      "DiffviewToggleFiles",
    },
    keys = {
      { "<leader>gvv", "<cmd>DiffviewOpen<cr>", desc = "Diffview (working tree)" },
      { "<leader>gvb", diffview_branch, desc = "Diffview (branch vs upstream/origin)" },
      { "<leader>gvp", diffview_pr, desc = "Diffview (PR vs its real base)" },
      { "<leader>gvf", "<cmd>DiffviewFileHistory %<cr>", desc = "File History (current file)" },
      { "<leader>gvF", "<cmd>DiffviewFileHistory<cr>", desc = "File History (repo)" },
      { "<leader>gvq", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
    },
    opts = {
      enhanced_diff_hl = true,
      show_help_hints = false,
      view = {
        default = {
          -- stacked, so each side keeps the full window width for long lines
          layout = "diff2_vertical",
          disable_diagnostics = true,
        },
        file_history = {
          layout = "diff2_vertical",
          disable_diagnostics = true,
        },
      },
      file_panel = {
        win_config = {
          position = "left",
          width = 28,
          win_opts = {
            number = false,
            relativenumber = false,
            signcolumn = "no",
          },
        },
      },
      file_history_panel = {
        win_config = {
          position = "bottom",
          height = 10,
          win_opts = {
            number = false,
            relativenumber = false,
            signcolumn = "no",
          },
        },
      },
      keymaps = {
        view = {
          {
            "n",
            "gw",
            function()
              local wrap = not vim.wo.wrap
              for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                if vim.wo[win].diff then
                  vim.wo[win].wrap = wrap
                end
              end
            end,
            { desc = "Toggle wrap (all diff windows)" },
          },
        },
      },
      hooks = {
        diff_buf_win_enter = function()
          vim.opt_local.list = false
          vim.opt_local.wrap = true
          vim.opt_local.linebreak = true -- break at word boundaries, not mid-token
          vim.opt_local.breakindent = true
          vim.opt_local.relativenumber = false
          vim.opt_local.signcolumn = "no"
          vim.opt_local.foldcolumn = "0"
          vim.opt_local.statuscolumn = ""
          vim.opt_local.colorcolumn = ""
        end,
      },
    },
  },
  {
    -- Interactive git interface
    "NeogitOrg/neogit",
    cmd = { "Neogit" },
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
    },
    config = true,
  },
  {
    -- modern blame view (window + virtual modes)
    "FabijanZulj/blame.nvim",
    cmd = { "BlameToggle" },
    keys = {
      { "<leader>gB", "<cmd>BlameToggle window<cr>", desc = "Blame Buffer (window)" },
      { "<leader>gV", "<cmd>BlameToggle virtual<cr>", desc = "Blame Buffer (virtual)" },
    },
    opts = {
      date_format = "%Y-%m-%d",
      merge_consecutive = false,
      max_summary_width = 30,
      commit_detail_view = "split",
    },
  },
  {
    -- label the <leader>gv prefix; opts_extend keeps LazyVim's own groups
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>gv", group = "diffview" },
      },
    },
  },
}
