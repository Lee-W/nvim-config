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
      -- Run the debugpy *adapter* via uv (`uv run --with debugpy ...`) so it always
      -- has debugpy and isn't pinned to whatever venv was active at startup. The
      -- debugged program's interpreter is still resolved per session from
      -- $VIRTUAL_ENV (set by venv-selector), so switching venvs is picked up
      -- without restarting nvim.
      require("dap-python").setup("uv")
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
    "nono/vim-handlebars",
    ft = { "html", "*.hbs", "*.handlebars" },
  },
  --------markdown
  {
    -- LazyVim's default build downloads a pre-built binary that is an unsigned
    -- arm64 Mach-O; Apple Silicon refuses to spawn it (E903 / errno 88). Build
    -- from source instead so the preview server runs through node.
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      file_types = { "markdown" },
      heading = { sign = false },
      code = { sign = false, width = "block", min_width = 60 },
    },
  },
  ------just file
  {
    "NoahTheDuke/vim-just",
    ft = "just",
  },
}
