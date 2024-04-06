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
          -- ## python
          require("none-ls.diagnostics.ruff"),
          null_ls.builtins.diagnostics.mypy,
          -- ## yaml
          null_ls.builtins.diagnostics.yamllint.with({ extra_args = { "-d", "relaxed" } }),
          null_ls.builtins.diagnostics.actionlint,

          -- # completion
          -- ## general
          null_ls.builtins.completion.spell,

          -- # formatting
          -- ## lua
          null_ls.builtins.formatting.stylua,
          -- ## python
          require("none-ls.formatting.ruff"),
          null_ls.builtins.formatting.black,
          -- ## yaml
          -- require("none-ls.formatting.yq"),
          -- ## json
          -- require("none-ls.formatting.jq"),
          -- ## markdown
          -- null_ls.builtins.formatting.mdformat,
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
}
