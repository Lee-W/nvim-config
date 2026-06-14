return {
  {
    -- lazyvim default; add lightweight inline current-line blame
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = { delay = 500 },
    },
  },
  {
    -- git wrapper
    "tpope/vim-fugitive",
  },
  {
    -- conflict resolver (lua-native: co/ct/cb/c0, ]x/[x to navigate)
    "akinsho/git-conflict.nvim",
    version = "*",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
  {
    -- :DiffView.*
    "sindrets/diffview.nvim",
  },
  {
    -- Interactive git interface
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "ibhagwan/fzf-lua", -- optional
    },
    config = true,
  },
  {
    -- modern blame view (window + virtual modes)
    "FabijanZulj/blame.nvim",
    cmd = { "BlameToggle" },
    keys = {
      { "<leader>gB", "<cmd>BlameToggle window<cr>", desc = "Blame Buffer (window)" },
      { "<leader>gV", "<cmd>BlameToggle virtual<cr>", desc = "Blame Buffer (virtual)" },
    },
    opts = {
      date_format = "%Y-%m-%d",
      merge_consecutive = false,
      max_summary_width = 30,
      commit_detail_view = "split",
    },
  },
}
