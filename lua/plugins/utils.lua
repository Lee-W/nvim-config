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
    opts = {
      defaults = {
        ["<leader>t"] = { name = "+test" },
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
    "RRethy/vim-illuminate",
    -- event = "VeryLazy",
    opts = {
      filetypes_denylist = {
        "dirvish",
        "fugitive",
        "md",
        "org",
        "norg",
        "NvimTree",
      },
    },
    keys = {
      { "<leader>ti", "<cmd>IlluminateToggle<CR>", desc = "[T]oggle [I]lluminate" },
      {
        "<leader>tf",
        function()
          require("illuminate").toggle_freeze_buf()
        end,
        desc = "[F]reeze Illuminate",
      },
    },
  },
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "numToStr/Comment.nvim", -- Optional
      "nvim-telescope/telescope.nvim", -- Optional
    },
    event = "VeryLazy",
    cmd = "Navbuddy",
    keys = { { "<F9>", "<CMD>Navbuddy<CR>", desc = "Navbuddy" } },
    opts = { lsp = { auto_attach = true }, window = { size = "80%" } },
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
