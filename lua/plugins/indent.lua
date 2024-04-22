return {

  {
    "echasnovski/mini.indentscope",
    version = false,
    config = function()
      require("mini.indentscope").setup()
    end,
  },
  {
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
