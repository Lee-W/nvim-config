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
      hooks = {
        diff_buf_win_enter = function(bufnr, winid)
          vim.opt_local.list = false
          vim.opt_local.wrap = true
          vim.opt_local.linebreak = true -- break at word boundaries, not mid-token
          vim.opt_local.breakindent = true
          vim.opt_local.relativenumber = false
          vim.opt_local.signcolumn = "no"
          vim.opt_local.foldcolumn = "0"
          vim.opt_local.statuscolumn = ""
          vim.opt_local.colorcolumn = ""

          -- side-by-side halves the width, so long lines get cut off; toggle wrap
          -- on both sides at once, since wrapping one side alone breaks alignment
          vim.keymap.set("n", "gw", function()
            local wrap = not vim.wo[winid].wrap
            for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
              if vim.wo[win].diff then
                vim.wo[win].wrap = wrap
              end
            end
          end, { buffer = bufnr, desc = "Toggle wrap (all diff windows)" })
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
