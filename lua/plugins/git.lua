return {
  {
    -- lazyvim default; add lightweight inline current-line blame
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = { delay = 500 },
    },
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
          vim.opt_local.wrap = false
          vim.opt_local.linebreak = true -- so toggled-on wrap breaks at word boundaries
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
}
