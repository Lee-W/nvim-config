return {
  {
    "Lee-W/ring.nvim",
    opts = {},
  },
  {
    -- included in lazyvim (customize behavior)
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.theme = "auto"
      vim.list_extend(opts.extensions, { "nvim-tree", "fugitive" })
      table.insert(opts.sections.lualine_x, 1, "ring")
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
  },
  -- cursorline: built-in vim.opt.cursorline (see config/options.lua); cursorword via illuminate
  -- included in lazyvim (customize behavior)
  { "nvim-mini/mini.ai", version = "*", opts = { n_lines = 1000 } },
}
