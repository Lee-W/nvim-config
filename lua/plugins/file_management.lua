return {
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    config = function()
      require("nvim-tree").setup({
        renderer = {
          show = {
            folder = true,
          },
        },
        indent_markers = {
          enable = false,
        },
        filters = {
          custom = {
            "^\\.git$",
            ".mypy_cache",
            ".pytest_cache",
            ".ruff_cache",
            ".ropeproject",
            "__pycache__",
            ".ipynb_checkpoints",
            ".hypothesis",
            ".DS_Store",
          },
        },
        git = { ignore = false },
      })
    end,
    keys = {
      { "<F2>", "<cmd>NvimTreeToggle<cr>" },
    },
    enabled = true,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        window = {
          width = 33,
        },
        enable_git_status = true,
        enable_diagnostics = true,
        filesystem = {
          filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = false,
            hide_gitignored = false,
            never_show = {
              ".git",
              ".mypy_cache",
              ".pytest_cache",
              ".ruff_cache",
              ".ropeproject",
              "__pycache__",
              ".ipynb_checkpoints",
              ".hypothesis",
            },
          },
        },
      })
    end,
    keys = {
      { "<F2>", "<cmd>Neotree toggle<cr>" },
    },
    enabled = false,
  },
}
