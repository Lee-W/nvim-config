local function assert_equal(actual, expected, label)
  assert(actual == expected, ("%s: expected %s, got %s"):format(label, vim.inspect(expected), vim.inspect(actual)))
end

local function contains(values, expected) return vim.tbl_contains(values, expected) end

-- Headless Neovim does not emit UIEnter, so trigger LazyVim's deferred user
-- configuration before checking FileType autocmds and lazy-loading behavior.
vim.api.nvim_exec_autocmds("User", { pattern = "VeryLazy" })

local lazy_config = require("lazy.core.config")
assert(not lazy_config.plugins["nvim-navbuddy"]._.loaded, "Navbuddy should load only when requested")
assert_equal(vim.fn.maparg("<leader>cn", "n", false, true).desc, "Navbuddy", "Navbuddy shortcut")
assert_equal(vim.fn.maparg("<leader>cN", "n", false, true).desc, "Generate Annotations (Neogen)", "Neogen shortcut")
assert_equal(vim.fn.maparg("`", "n"), "", "native mark jump")

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

-- Check what the plugin actually consumes, not just the spec (unknown top-level
-- options are silently ignored by venv-selector).
check_file("app.py", "python", 4, "venv-selector.nvim")
local venv_opts = require("venv-selector.config").get_user_options()
assert_equal(venv_opts.picker, "snacks", "venv-selector picker")
assert_equal(venv_opts.enable_cached_venvs, true, "venv-selector cache")
assert_equal(venv_opts.activate_venv_in_terminal, true, "venv-selector terminal activation")
assert_equal(venv_opts.notify_user_on_venv_activation, true, "venv-selector notification")
assert(lazy_config.plugins["fzf-lua"] == nil, "fzf-lua should not be part of the resolved plugin spec")
assert(lazy_config.plugins["toggleterm.nvim"] == nil, "toggleterm.nvim should not be part of the resolved plugin spec")

-- Exercise the documented native commenting mappings, including after loading
-- Navbuddy's Comment.nvim dependency, which must not replace them.
local comment_lines = { "first = 1", "second = 2", "third = 3" }
for _, load_navbuddy in ipairs({ false, true }) do
  if load_navbuddy then
    assert(not lazy_config.plugins["nvim-navbuddy"]._.loaded, "file editing should not eagerly load Navbuddy")
    require("lazy").load({ plugins = { "nvim-navbuddy" } })
    assert(lazy_config.plugins["nvim-navbuddy"]._.loaded, "Navbuddy did not load on demand")
  end

  for _, keys in ipairs({ "3gcc", "gcap", "Vjjgc" }) do
    vim.api.nvim_buf_set_lines(0, 0, -1, false, comment_lines)
    vim.api.nvim_win_set_cursor(0, { 1, 0 })
    vim.cmd.normal(keys)
    assert(
      vim.deep_equal(vim.api.nvim_buf_get_lines(0, 0, -1, false), { "# first = 1", "# second = 2", "# third = 3" }),
      keys .. " commented lines"
    )
    vim.api.nvim_win_set_cursor(0, { 1, 0 })
    vim.cmd.normal("3gcc")
    assert(vim.deep_equal(vim.api.nvim_buf_get_lines(0, 0, -1, false), comment_lines), keys .. " uncomment round trip")
  end
end
vim.bo.modified = false

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
