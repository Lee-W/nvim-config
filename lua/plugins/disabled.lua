return {
  ---- utils
  {
    -- not used

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
  {

    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
    },
    config = true,
    enabled = false,
  },
}
