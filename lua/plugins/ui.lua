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
  {
    "yamatsum/nvim-cursorline",
    config = function()
      require("nvim-cursorline").setup({
        cursorline = {
          enable = true,
          timeout = 1000,
          number = false,
        },
        -- cursorword handled by illuminate (extras.editor.illuminate)
        cursorword = {
          enable = false,
        },
      })
    end,
  },
  -- included in lazyvim (customize behavior)
  { "nvim-mini/mini.ai", version = "*", opts = { n_lines = 1000 } },
}
