return {
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        filters = {
          custom = {
            "^\\.git$",
            ".mypy_cache",
            ".pytest_cache",
            ".ropeproject",
            "__pycache__",
            ".ipynb_checkpoints",
            ".hypothesis",
          },
        },
      })
    end,
    keys = {
      { "<F2>", "<cmd>NvimTreeToggle<cr>" },
    },
  },
}
