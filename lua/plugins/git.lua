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
          disable_diagnostics = true,
        },
        file_history = {
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
        diff_buf_win_enter = function()
          vim.opt_local.list = false
          vim.opt_local.wrap = false
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
}
