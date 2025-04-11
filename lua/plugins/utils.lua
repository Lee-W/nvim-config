return {
  {
    "editorconfig/editorconfig-vim",
  },
  {
    "majutsushi/tagbar",
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
    "vim-scripts/dbext.vim",
  },
  {
    "tmhedberg/SimpylFold",
    ft = "python",
  },
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("hlslens").setup()
    end,
  },
  {
    "yamatsum/nvim-cursorline",
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "romgrk/barbar.nvim",
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
  {
    "phaazon/hop.nvim",
    opts = {
      branch = "v2",
    },
  },
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
}
