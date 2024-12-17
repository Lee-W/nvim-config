return {
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<C-P>", "<cmd>FzfLua files<cr>" },
    },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({ winopts = { height = 0.9, width = 0.9 } })
    end,
  },
}
