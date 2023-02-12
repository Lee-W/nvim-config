return {
  {
    "airblade/vim-gitgutter",
  },
  {
    "tpope/vim-fugitive",
  },
  {
    "akinsho/git-conflict.nvim",
    config = function()
      require("git-conflict").setup()
    end,
  },
  {
    "sindrets/diffview.nvim",
  },
}
