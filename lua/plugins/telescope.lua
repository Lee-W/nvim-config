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
      { "<C-P>", "<cmd>Telescope find_files<cr>" },
      { "<C-B>", "<cmd>Telescope grep_string<cr>" },
    },
    -- autocmd FileType TelescopePrompt call deoplete#custom#buffer_option('auto_complete', v:false)
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  },
}
