return {
  {
    -- tab line
    "romgrk/barbar.nvim",
  },
  {
    -- included in lazyvim (customize behavior)
    "nvim-lualine/lualine.nvim",
    opts = {
      options = { theme = "catppuccin" },
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
        cursorword = {
          enable = true,
          min_length = 3,
          hl = { underline = true },
        },
      })
    end,
  },
  -- included in lazyvim (customize behavior)
  { "nvim-mini/mini.ai", version = "*", opts = { n_lines = 1000 } },
}
