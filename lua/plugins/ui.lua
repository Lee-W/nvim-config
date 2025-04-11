return {
  {
    -- tab line
    "AckslD/nvim-neoclip.lua",
  },
  {
    -- included in lazyvim (customize behavior)
    "nvim-lualine/lualine.nvim",
    opts = {
      options = { theme = "nightfox" },
      extensions = { "nvim-tree", "fugitive" },
    },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
  },
}
