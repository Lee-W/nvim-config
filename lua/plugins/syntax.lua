return {
  --------python
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python", --optional
    },
    ft = "python",
    keys = {
      { ",v", "<cmd>VenvSelect<cr>" },
    },
    opts = {
      -- auto_refresh = true,
      enable_cached_venvs = true,
      activate_venv_in_terminal = true,
      show_telescope_search_type = true,
      notify_user_on_venv_activation = true,
      picker = "fzf-lua",
    },
    lazy = true,
    enabled = true,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      require("nvim-dap-virtual-text").setup({})
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    end,
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Conditional breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step over" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step out" },
      { "<leader>dq", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local venv = os.getenv("VIRTUAL_ENV")
      local py = venv and (venv .. "/bin/python") or "python"
      require("dap-python").setup(py)
    end,
    keys = {
      { "<leader>dt", function() require("dap-python").test_method() end, ft = "python", desc = "Debug test method" },
      { "<leader>dT", function() require("dap-python").test_class() end, ft = "python", desc = "Debug test class" },
      { "<leader>ds", function() require("dap-python").debug_selection() end, mode = "v", ft = "python", desc = "Debug selection" },
    },
  },
  {
    "Glench/Vim-Jinja2-Syntax",
    ft = { "html", "*.j2", "*.jinja" },
  },
  --------Web
  {
    "mattn/emmet-vim",
    ft = { "html", "css" },
  },
  {
    "othree/yajs.vim",
    ft = "javascript",
  },
  {
    "othree/javascript-libraries-syntax.vim",
    ft = "javascript",
  },
  {
    "nono/vim-handlebars",
    ft = { "html", "*.hbs", "*.handlebars" },
  },
  --------markdown
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "Avante", "copilot-chat" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      file_types = { "markdown", "Avante", "copilot-chat" },
      heading = { sign = false },
      code = { sign = false, width = "block", min_width = 60 },
    },
  },
  ------rust
  {
    "rust-lang/rust.vim",
    ft = "rust",
  },
  ------just file
  {
    "NoahTheDuke/vim-just",
    ft = "just",
  },
}
