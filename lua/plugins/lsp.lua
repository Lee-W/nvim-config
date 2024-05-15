return {
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvimtools/none-ls-extras.nvim" },
    opts = function()
      local null_ls = require("null-ls")
      return {
        sources = {
          -- # diagnostics
          -- ## general
          null_ls.builtins.diagnostics.codespell,
          -- ## yaml
          null_ls.builtins.diagnostics.actionlint,

          -- # completion
          -- ## general
          null_ls.builtins.completion.spell,

          -- # formatting
          -- ## lua
          null_ls.builtins.formatting.stylua,
        },
      }
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
  },
  {
    -- change nvim-lspconfig options
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          autostart = false,
        },
      },
    },
  },
  {
    "dense-analysis/ale",
    config = function()
      -- Configuration goes here.
      local g = vim.g

      local fixers = {}
      fixers["*"] = { "remove_trailing_lines", "trim_whitespace" }
      fixers["python"] = { "black", "ruff_format" }
      g.ale_fixers = fixers

      g.ale_linters = {
        lua = { "lua_language_server" },
        python = { "ruff", "mypy" },
        dockerfile = { "hadolint" },
      }
      g.ale_fix_on_save = 1
      g.ale_fix_on_save = 1
      g.ale_python_bandit_options = "-iii -lll -s=B322"
      g.ale_python_mypy_options = "--ignore-missing-imports"
      g.ale_python_auto_pipenv = 1
      g.ale_yaml_yamllint_options = "-d relaxed"
      g.ale_open_list = 1
      g.ale_list_window_size = 6
    end,
  },
}
