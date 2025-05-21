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
  -- included in lazyvim (customize behavior)
  {
    -- linting
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters = {
        markdownlint = {
          args = {
            "--config",
            vim.fn.stdpath("config") .. "lua/plugins/config/.markdownlint.json",
            "--",
          },
        },
        ["markdownlint-cli2"] = {
          args = {
            "--config",
            vim.fn.stdpath("config") .. "lua/plugins/config/.markdownlint.json",
            "--",
          },
        },
      },
    },
  },
  {
    -- formatting
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
}
