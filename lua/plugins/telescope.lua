return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    "nvim-telescope/telescope.nvim",
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
    build = "make",
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
}
