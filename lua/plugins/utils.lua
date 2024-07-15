return {
  {
    "editorconfig/editorconfig-vim",
  },
  {
    "majutsushi/tagbar",
  },
  {
    "akinsho/bufferline.nvim",
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
    "luochen1990/rainbow",
  },
  {
    "tpope/vim-surround",
  },
  {
    "terryma/vim-expand-region",
  },
  {
    "machakann/vim-highlightedyank",
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
    "nvim-lualine/lualine.nvim",
    opts = {
      options = { theme = "nightfox" },
      extensions = { "nvim-tree", "fugitive" },
    },
  },
  {
    "yamatsum/nvim-cursorline",
  },
  {
    "gelguy/wilder.nvim",
    build = "UpdateRemotePlugins",
    config = function()
      local wilder = require("wilder")
      wilder.setup({ modes = { ":", "/", "?" } })

      wilder.set_option("pipeline", {
        wilder.branch(wilder.cmdline_pipeline(), wilder.search_pipeline()),
      })

      wilder.set_option(
        "renderer",
        wilder.wildmenu_renderer({
          highlighter = wilder.basic_highlighter(),
        })
      )
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "AckslD/nvim-neoclip.lua",
  },
  {
    "romgrk/barbar.nvim",
  },
  {
    "dstein64/vim-startuptime",
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
    "folke/which-key.nvim",
    optional = true,
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
