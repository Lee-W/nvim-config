return {
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
          -- Installed via `uv tool install basedpyright`, not mason: mason builds a
          -- venv with the uv-managed standalone python3, whose ensurepip is broken
          -- ("No module named 'encodings'"), so the mason install fails.
          mason = false,
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
  -- included in lazyvim (customize behavior)
  {
    -- formatting
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
        rust = { "rustfmt", lsp_format = "fallback" },
        -- toml = { "taplo" },
        markdown = { "rumdl" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettier" }, -- Use Prettier for CSS files
        -- codespell removed: auto-"fixes" valid words on save (e.g. ser -> set)
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
    },
  },
}
