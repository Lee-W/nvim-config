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
  {
    -- replaced by lazyvim setup
    "glepnir/dashboard-nvim",
    enabled = false,
  },
  -- {
  -- cannot setup correctly as of now, but lazyvim's default setting works
  -- "junegunn/fzf",
  -- enabled = false,
  -- },
  -- {
  -- cannot setup correctly as of now, but lazyvim's default setting works
  -- "junegunn/fzf.vim",
  -- opts = {
  --   wildignore = { "*/tmp/*", "*.so", "*.swp", "*.zip" },
  --   fzf_buffer_jump = 1,
  -- },
  -- keys = {
  --   { "<C-F>", "<cmd>Rg<cr>" },
  --   { ";", ":Buffers<cr>" },
  -- },
  -- enabled = false,
  -- },

  ---- git
  -- {
  --   -- replaced with akinsho/git-conflict.nvim
  --   "rhysd/conflict-marker.vim",
  --   enabled = false,
  -- },

  ---- snippets
  {
    "SirVer/ultisnips",
    enabled = false,
  },
  {
    "honza/vim-snippets",
    enabled = false,
  },
}
