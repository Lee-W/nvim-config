return {
  {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
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
        taplo = {},
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

      local fixers = {}
      -- leave the responsibility to conform.nvim
      fixers["python"] = {}
      g.ale_fixers = fixers

      g.ale_linters = {
        lua = { "lua_language_server" },
        python = { "mypy", "bandit", "ruff" },
        dockerfile = { "hadolint" },
        yaml = {},
      }
      -- ale general config
      g.ale_fix_on_save = 1
      g.ale_open_list = 1
      g.ale_list_window_size = 6
      -- python
      g.ale_python_bandit_options = "-iii -lll -s=B322"
      g.ale_python_mypy_options = "--ignore-missing-imports"
      g.ale_python_auto_virtualenv = 1
      g.ale_python_auto_uv = 1
      g.ale_python_ruff_auto_uv = 1
      g.ale_python_ruff_format_auto_uv = 1
      -- markdown
      g.ale_markdown_markdownlint_options = "--config "
        .. vim.fn.stdpath("config")
        .. "/lua/plugins/config/.markdownlint.json --"
      -- yaml
      g.ale_yaml_yamllint_options = "-d relaxed"
    end,
    -- enabled = false,
  },
  -- included in lazyvim (customize behavior)
  {
    -- formatting
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
        rust = { "rustfmt", lsp_format = "fallback" },
        -- toml = { "taplo" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        ["*"] = { "codespell" },
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
}
