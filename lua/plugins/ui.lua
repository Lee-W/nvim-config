return {
  {
    -- included in lazyvim (customize behavior)
    "nvim-lualine/lualine.nvim",
    opts = {
      options = { theme = "auto" },
      extensions = { "nvim-tree", "fugitive" },
    },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
  },
  -- cursorline: built-in vim.opt.cursorline (see config/options.lua); cursorword via illuminate
  -- included in lazyvim (customize behavior)
  { "nvim-mini/mini.ai", version = "*", opts = { n_lines = 1000 } },
}
