local function assert_equal(actual, expected, label)
  assert(actual == expected, ("%s: expected %s, got %s"):format(label, vim.inspect(expected), vim.inspect(actual)))
end

local function contains(values, expected) return vim.tbl_contains(values, expected) end

-- Headless Neovim does not emit UIEnter, so trigger LazyVim's deferred user
-- configuration before checking FileType autocmds and lazy-loading behavior.
vim.api.nvim_exec_autocmds("User", { pattern = "VeryLazy" })

local lazy_config = require("lazy.core.config")
local tempdir = vim.fn.tempname()
vim.fn.mkdir(tempdir, "p")

local function check_file(filename, expected_ft, expected_shiftwidth, plugin)
  local path = tempdir .. "/" .. filename
  vim.fn.writefile({}, path)
  vim.cmd.edit(vim.fn.fnameescape(path))
  vim.wait(1000, function() return vim.bo.filetype ~= "" end)

  assert_equal(vim.bo.filetype, expected_ft, filename .. " filetype")
  assert_equal(vim.bo.shiftwidth, expected_shiftwidth, filename .. " shiftwidth")

  if plugin then
    vim.wait(1000, function() return lazy_config.plugins[plugin]._.loaded ~= nil end)
    assert(lazy_config.plugins[plugin]._.loaded, plugin .. " was not loaded for " .. filename)
  end
end

check_file("template.j2", "jinja", 2, "Vim-Jinja2-Syntax")
check_file("template.hbs", "handlebars.html", 2, "vim-handlebars")
check_file("app.js", "javascript", 2)
check_file("app.jsx", "javascriptreact", 2)
check_file("app.ts", "typescript", 2)
check_file("app.tsx", "typescriptreact", 2)

local lsp_opts = lazy_config.plugins["nvim-lspconfig"].opts
assert_equal(
  lsp_opts.servers.basedpyright.settings.basedpyright.analysis.typeCheckingMode,
  "basic",
  "BasedPyright type checking"
)

local venv_opts = lazy_config.plugins["venv-selector.nvim"].opts
assert_equal(venv_opts.picker, "snacks", "venv-selector picker")
assert(lazy_config.plugins["fzf-lua"] == nil, "fzf-lua should not be part of the resolved plugin spec")
assert(lazy_config.plugins["toggleterm.nvim"] == nil, "toggleterm.nvim should not be part of the resolved plugin spec")

local formatter_opts = lazy_config.plugins["conform.nvim"].opts.formatters_by_ft
for _, ft in ipairs({ "javascript", "javascriptreact", "typescript", "typescriptreact" }) do
  local formatters = formatter_opts[ft]
  assert(formatters, "missing formatter configuration for " .. ft)
  assert(contains(formatters, "prettierd"), "prettierd is not configured for " .. ft)
  assert(contains(formatters, "prettier"), "prettier fallback is not configured for " .. ft)
  assert_equal(formatters.stop_after_first, true, ft .. " formatter fallback")
end

vim.fn.delete(tempdir, "rf")
print("Configuration smoke checks: ok")
