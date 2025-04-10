return {
  {
    -- git wrapper
    "tpope/vim-fugitive",
  },
  {
    -- conflict resolver
    "rhysd/conflict-marker.vim",
  },
  {
    -- git diff markers
    "airblade/vim-gitgutter",
  },
  {
    -- :DiffView.*
    "sindrets/diffview.nvim",
  },
  {
    -- Interactive git interface
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "ibhagwan/fzf-lua", -- optional
    },
    config = true,
  },
}
