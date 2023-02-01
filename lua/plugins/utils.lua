return {
  {
    "editorconfig/editorconfig-vim",
  },
  {
    "majutsushi/tagbar",
  },
  {
    "liangfeng/TaskList.vim",
    -- opts = {
    --   tlTokenList = {"FIXME", "TODO", "XXX"}
    -- }
  },
  {
    "junegunn/fzf",
  },
  {
    "junegunn/fzf.vim",
    opts = {
      wildignore = { "*/tmp/*", "*.so", "*.swp", "*.zip" },
      fzf_buffer_jump = 1,
    },
    keys = {
      { "<C-F>", "<cmd>Rg<cr>" },
      { ";", ":Buffers<cr>" },
    },
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
    "nvim-treesitter/nvim-treesitter",
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
    "nvim-telescope/telescope-fzf-native.nvim",
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
    "folke/which-key.nvim",
  },
  {
    "phaazon/hop.nvim",
    opts = {
      create_hl_autocmd = true,
    },
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
  --   {
  --   "romgrk/barbar.nvim",
  -- },
  {
    "henriquehbr/nvim-startup.lua",
  },
}
