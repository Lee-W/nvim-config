return {

  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local null_ls = require("null-ls")
      return {
        sources = {
          -- # diagnostics
          -- ## general
          null_ls.builtins.diagnostics.codespell,
          -- ## python
          null_ls.builtins.diagnostics.ruff,
          -- null_ls.builtins.diagnostics.mypy,
          -- null_ls.builtins.diagnostics.bandit.with({ extra_args = { "-iii", "-lll", "-s=B322" } }),
          null_ls.builtins.diagnostics.pycodestyle,
          -- ## yaml
          null_ls.builtins.diagnostics.yamllint.with({ extra_args = { "-d", "relaxed" } }),

          -- # completion
          -- ## general
          null_ls.builtins.completion.spell,

          -- # formatting
          -- ## general
          null_ls.builtins.formatting.trim_whitespace,
          null_ls.builtins.formatting.trim_newlines,
          -- ## lua
          null_ls.builtins.formatting.stylua,
          -- ## python
          null_ls.builtins.formatting.ruff,
          null_ls.builtins.formatting.black,
          -- ## json
          null_ls.builtins.formatting.json_tool,
          -- ## markdown
          -- null_ls.builtins.formatting.mdformat,
        },
      }
    end,
  },
}
