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
    "nvim-lua/plenary.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<C-P>", "<cmd>Telescope find_files<cr>" },
      { "<C-B>", "<cmd>Telescope grep_string<cr>" },
    },
    -- autocmd FileType TelescopePrompt call deoplete#custom#buffer_option('auto_complete', v:false)
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      show_end_of_line = true,
      show_current_context = true,
    },
    config = function()
      vim.opt.listchars:append("space:⋅")
      vim.opt.listchars:append("eol:↴")
    end,
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
}
