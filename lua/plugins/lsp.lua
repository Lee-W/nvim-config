return {

  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim", "nvimtools/none-ls-extras.nvim" },
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

          -- # completion
          -- ## general
          null_ls.builtins.completion.spell,

          -- # formatting
          -- ## lua
          null_ls.builtins.formatting.stylua,
          -- ## python
          require("none-ls.formatting.ruff"),
          null_ls.builtins.formatting.black,
          -- ## json
          -- require("none-ls.formatting.jq"),
          -- ## markdown
          -- null_ls.builtins.formatting.mdformat,
        },
      }
    end,
  },
}
