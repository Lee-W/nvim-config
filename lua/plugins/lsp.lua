return {
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = { "nvimtools/none-ls-extras.nvim" },
  --   enable = false,
  --   opts = function()
  --     local null_ls = require("null-ls")
  --     return {
  --       sources = {
  --         -- # diagnostics
  --         -- ## general
  --         null_ls.builtins.diagnostics.codespell,
  --
  --         -- ## python
  --         -- require("none-ls.diagnostics.ruff"),
  --         null_ls.builtins.diagnostics.mypy,
  --
  --         -- ## yaml
  --         null_ls.builtins.diagnostics.actionlint,
  --
  --         -- # completion
  --         -- ## general
  --         null_ls.builtins.completion.spell,
  --
  --         -- ## lua
  --         null_ls.builtins.formatting.stylua,
  --       },
  --     }
  --   end,
  -- },
  -- {
  --   "jay-babu/mason-null-ls.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   enable = false,
  --   dependencies = {
  --     "williamboman/mason.nvim",
  --     "nvimtools/none-ls.nvim",
  --   },
  -- },
  {
    -- change nvim-lspconfig options
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
          "numToStr/Comment.nvim", -- Optional
          "nvim-telescope/telescope.nvim", -- Optional
        },
        event = "VeryLazy",
        cmd = "Navbuddy",
        keys = { { "<F9>", "<CMD>Navbuddy<CR>", desc = "Navbuddy" } },
        opts = { lsp = { auto_attach = true } },
        window = { size = "80%" },
      },
    },
    opts = {
      servers = {
        pyright = {
          disableOrganizeImports = true, -- Using Ruff
          reportMissingImports = false,
          reportCallIssue = false,
          -- autostart = false,
        },
        -- basedpyright = {},
      },
      setup = {
        python = {
          analysis = {
            ignore = { "*" }, -- Using Ruff
            typeCheckingMode = "off", -- Using mypy
            diagnosticMode = "off",
          },
        },
      },
    },
  },
  {
    "dense-analysis/ale",
    config = function()
      -- Configuration goes here.
      local g = vim.g

      g.ale_linters = {
        lua = { "lua_language_server" },
        -- python = { "mypy" },
        python = {},
        dockerfile = { "hadolint" },
        yaml = {},
      }
      g.ale_fix_on_save = 1
      g.ale_fix_on_save = 1
      g.ale_python_bandit_options = "-iii -lll -s=B322"
      g.ale_python_mypy_options = "--ignore-missing-imports"
      g.ale_python_auto_virtualenv = 1
      g.ale_yaml_yamllint_options = "-d relaxed"
      g.ale_open_list = 1
      g.ale_list_window_size = 6
    end,
  },
}
