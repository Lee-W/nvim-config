return {
  {
    "airblade/vim-gitgutter",
  },
  {
    "tpope/vim-fugitive",
  },
  {
    "rhysd/conflict-marker.vim",
  },
  {
    "sindrets/diffview.nvim",
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "ibhagwan/fzf-lua", -- optional
    },
    config = true,
  },
}
