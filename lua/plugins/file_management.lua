return {
  -- using nvim-tree below; turn off lazyvim's default neo-tree to avoid duplicate trees
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    lazy = true,
    cmd = {
      "NvimTreeClipboard",
      "NvimTreeClose",
      "NvimTreeCollapse",
      "NvimTreeFindFile",
      "NvimTreeFindFileToggle",
      "NvimTreeFocus",
      "NvimTreeOpen",
      "NvimTreeRefresh",
      "NvimTreeResize",
      "NvimTreeToggle",
    },
    config = function()
      require("nvim-tree").setup({
        filters = {
          custom = {
            "^\\.git$",
            ".mypy_cache",
            ".pytest_cache",
            ".ruff_cache",
            ".ropeproject",
            "__pycache__",
            ".ipynb_checkpoints",
            ".hypothesis",
            ".DS_Store",
          },
        },
        git = { ignore = false },
      })
    end,
    keys = {
      { "<F2>", "<cmd>NvimTreeToggle<cr>" },
    },
    enabled = true,
  },
}
