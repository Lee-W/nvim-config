return {
  {
    "editorconfig/editorconfig-vim",
  },
  {
    -- Clipboard manager
    "AckslD/nvim-neoclip.lua",
  },
  {
    -- code outline window
    "stevearc/aerial.nvim",
    opts = {
      layout = {
        default_direction = "prefer_left",
      },
    },
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "liangfeng/TaskList.vim",
    config = function()
      vim.g.tlTokenList = { "FIXME", "TODO", "XXX" }
    end,
  },
  {
    "vim-scripts/vimspell",
    ft = "txt, md, tex",
    opts = {
      spelllang = "en",
    },
  },
  {
    "tomtom/tcomment_vim",
  },
  {
    "tpope/vim-repeat",
  },
  {
    -- use +/_ to expand/shrink select region
    "terryma/vim-expand-region",
  },
  {
    -- folding for Python
    "tmhedberg/SimpylFold",
    ft = "python",
  },
  {
    -- easier serach
    "kevinhwang91/nvim-hlslens",
  },
  -- included in lazyvim (customize behavior)
  {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = {
        "c",
        "lua",
        "python",
        "json",
        "just",
        "query",
        "vim",
        "yaml",
        "markdown",
      },
      highlight = { enable = true },
      indent = { enable = true, disable = { "python" } },
    },
    config = function(_, opts)
      -- pcall(require("nvim-treesitter.install").update({ with_sync = true }))
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          jump_labels = true,
        },
      },
    },
  },
}
