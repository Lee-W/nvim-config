return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          -- nls.builtins.formatting.prettierd,
          nls.builtins.formatting.stylua,
          nls.builtins.diagnostics.flake8.with({
            args = {
              "--format",
              "default",
              "--stdin-display-name",
              "$FILENAME",
              "-",
              "--ignore=W503,E501,F632,E203",
              "--max-line-length=88",
            },
          }),
        },
      }
    end,
  },
}
