return {
  {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
  },
  {
    -- change nvim-lspconfig options
    "neovim/nvim-lspconfig",
    dependencies = {
      { "b0o/SchemaStore.nvim", version = false },
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
          "numToStr/Comment.nvim", -- Optional
        },
        event = "VeryLazy",
        cmd = "Navbuddy",
        keys = { { "<F9>", "<CMD>Navbuddy<CR>", desc = "Navbuddy" } },
        opts = {
          lsp = { auto_attach = true },
          window = { size = "80%" },
        },
      },
    },
    opts = {
      servers = {
        ["*"] = {
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
        },
        basedpyright = {
          settings = {
            basedpyright = {
              disableOrganizeImports = true, -- Using Ruff
              analysis = {
                typeCheckingMode = "off", -- mypy via pre-commit / CI
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
                autoImportCompletions = true,
                diagnosticSeverityOverrides = {
                  reportMissingImports = "none",
                  reportCallIssue = "none",
                },
              },
            },
          },
        },
        ruff = {},
        taplo = {},
        jinja_lsp = {
          filetypes = { "jinja", "html" },
        },
        yamlls = {
          on_new_config = function(config)
            config.settings.yaml.schemas = vim.tbl_deep_extend(
              "force",
              config.settings.yaml.schemas or {},
              require("schemastore").yaml.schemas()
            )
          end,
          settings = {
            yaml = {
              validate = true,
              schemaStore = { enable = false, url = "" },
              schemas = {},
            },
          },
        },
        jsonls = {
          on_new_config = function(config)
            config.settings.json.schemas = config.settings.json.schemas or {}
            vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
          end,
          settings = {
            json = {
              format = { enable = true },
              validate = { enable = true },
            },
          },
        },
      },
    },
  },
  {
    "dense-analysis/ale",
    enabled = false,
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
        ["*"] = { "codespell" },
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
        markdown = { "rumdl" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettier" }, -- Use Prettier for CSS files
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
