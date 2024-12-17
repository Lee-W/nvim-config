return {
  ---- utils
  {
    "nvim-pack/nvim-spectre",
    -- nnoremap <leader>S :lua require('spectre').open()<CR>
    -- "search current word
    -- nnoremap <leader>sw :lua require('spectre').open_visual({select_word=true})<CR>
    -- vnoremap <leader>s :lua require('spectre').open_visual()<CR>
    -- "  search in current file
    -- nnoremap <leader>sp viw:lua require('spectre').open_file_search()<cr>
    enabled = false,
  },

  ---- snippets
  -- {
  --   "SirVer/ultisnips",
  --   enabled = false,
  -- },
  -- {
  --   "honza/vim-snippets",
  --   enabled = false,
  -- },
  ---- git
  -- {
  --
  --   "NeogitOrg/neogit",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim", -- required
  --     "sindrets/diffview.nvim", -- optional - Diff integration
  --
  --     -- Only one of these is needed, not both.
  --     "nvim-telescope/telescope.nvim", -- optional
  --     "ibhagwan/fzf-lua", -- optional
  --   },
  --   config = true,
  --   enabled = false,
  -- },

  ---- telescope
  -- Fuzzy Finder (files, lsp, etc)
  {
    "nvim-telescope/telescope.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep",
      "sharkdp/fd",
      "nvim-treesitter/nvim-treesitter",
    },
    build = ":TSUpdate",
    keys = {
      { "<C-P>", "<cmd>Telescope find_files find_command=rg,--files,--hidden,-g,!.git<cr>" },
      { "<C-B>", "<cmd>Telescope grep_string<cr>" },
    },
    config = function()
      require("telescope").setup({
        pickers = {
          find_files = {
            hidden = true,
          },
        },
        file_ignore_patterns = {
          ".git/.*",
          ".DS_Store",
        },
      })
      require("telescope").load_extension("file_browser")
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    enabled = false,
    build = "make",
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    enabled = false,
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
}
