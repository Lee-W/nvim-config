return {
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
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
          -- "nvim-telescope/telescope.nvim", -- Optional
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
        ruff = {},
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
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
        -- python = {},
        rust = { "rustfmt", lsp_format = "fallback" },
        -- ["*"] = { "codespell" },
        ["_"] = { "trim_whitespace", "trim_newlines" },
      },
      formatters = {
        ruff_fix = {
          args = {
            "check",
            "--fix",
            -- "--force-exclude",
            "--exit-zero",
            "--no-cache",
            "--stdin-filename",
            "$FILENAME",
            "-",
          },
        },
        ruff_format = {
          args = {
            "format",
            -- "--force-exclude",
            "--stdin-filename",
            "$FILENAME",
            "-",
          },
        },
        ruff_organize_imports = {
          args = {
            "check",
            "--fix",
            -- "--force-exclude",
            "--select=I001",
            "--exit-zero",
            "--no-cache",
            "--stdin-filename",
            "$FILENAME",
            "-",
          },
        },
      },
      log_level = vim.log.levels.DEBUG,
    },
  },
  {
    "dense-analysis/ale",
    config = function()
      -- Configuration goes here.
      local g = vim.g

      local fixers = {}
      fixers["python"] = {}
      -- fixers["python"] = { "ruff", "ruff_format" }
      g.ale_fixers = fixers

      g.ale_linters = {
        lua = { "lua_language_server" },
        python = { "mypy", "bandit", "ruff" },
        dockerfile = { "hadolint" },
        yaml = {},
      }
      g.ale_fix_on_save = 1
      g.ale_python_bandit_options = "-iii -lll -s=B322"
      g.ale_python_mypy_options = "--ignore-missing-imports"
      g.ale_python_auto_virtualenv = 1
      g.ale_python_auto_uv = 1
      g.ale_python_ruff_auto_uv = 1
      g.ale_python_ruff_format_auto_uv = 1
      g.ale_yaml_yamllint_options = "-d relaxed"
      g.ale_open_list = 1
      g.ale_list_window_size = 6
    end,
  },
}
