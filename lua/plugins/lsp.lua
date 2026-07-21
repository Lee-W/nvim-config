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
          -- uv workspaces nest a pyproject.toml under every member (e.g. providers/<name>),
          -- which shadows the real workspace root under the default root_markers and
          -- strands basedpyright without the shared .venv (breaks import resolution /
          -- go-to-definition across packages). uv.lock only exists at actual workspace
          -- roots -- including isolated sub-workspaces like dev/breeze -- so prefer it.
          root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            on_dir(vim.fs.root(fname, "uv.lock") or vim.fs.root(fname, {
              "pyrightconfig.json",
              "pyproject.toml",
              "setup.py",
              "setup.cfg",
              "requirements.txt",
              "Pipfile",
              ".git",
            }))
          end,
          -- Without venvPath/venv or python.pythonPath, basedpyright falls back to
          -- whatever `python` is on $PATH -- it never auto-detects a .venv folder.
          -- Point it at this root's own venv (each uv sub-workspace above has one).
          on_init = function(client)
            local venv_python = client.root_dir .. "/.venv/bin/python"
            if vim.uv.fs_stat(venv_python) then
              client.settings =
                vim.tbl_deep_extend("force", client.settings or {}, { python = { pythonPath = venv_python } })
            end
          end,
          settings = {
            basedpyright = {
              disableOrganizeImports = true, -- Using Ruff
              analysis = {
                -- Keep editor feedback lightweight; stricter mypy checks still run in pre-commit / CI.
                typeCheckingMode = "basic",
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
                autoImportCompletions = true,
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
            config.settings.yaml.schemas =
              vim.tbl_deep_extend("force", config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
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
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
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
