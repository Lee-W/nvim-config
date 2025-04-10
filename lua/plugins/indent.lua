return {
  {
    -- included in lazyvim (customize behavior)
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      show_end_of_line = true,
      show_current_context = true,
    },
    config = function()
      vim.opt.listchars:append("space:⋅")
      vim.opt.listchars:append("eol:↴")
    end,
    enable = false,
  },
}
