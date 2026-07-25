return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
    },
    ft = "python",
    -- `opts`, not `config`: a custom `config` replaces LazyVim's, which is what wires
    -- up the trouble consumer, quickfix opener, status virtual text and the neotest
    -- diagnostic namespace. LazyVim resolves adapter names from this table itself.
    opts = {
      adapters = {
        ["neotest-python"] = {
          dap = { justMyCode = false },
          runner = "pytest",
        },
      },
    },
    keys = {
      {
        "<leader>tr",
        function() require("neotest").run.run() end,
        desc = "Run nearest test",
      },
      {
        "<leader>tf",
        function() require("neotest").run.run(vim.fn.expand("%")) end,
        desc = "Run file",
      },
      {
        "<leader>ta",
        function() require("neotest").run.run(vim.uv.cwd()) end,
        desc = "Run all",
      },
      {
        "<leader>tl",
        function() require("neotest").run.run_last() end,
        desc = "Run last",
      },
      {
        "<leader>td",
        function() require("neotest").run.run({ strategy = "dap" }) end,
        desc = "Debug nearest",
      },
      {
        "<leader>ts",
        function() require("neotest").summary.toggle() end,
        desc = "Toggle summary",
      },
      {
        "<leader>to",
        function() require("neotest").output.open({ enter = true, auto_close = true }) end,
        desc = "Show output",
      },
      {
        "<leader>tO",
        function() require("neotest").output_panel.toggle() end,
        desc = "Toggle output panel",
      },
      {
        "<leader>tx",
        function() require("neotest").run.stop() end,
        desc = "Stop",
      },
    },
  },
}
