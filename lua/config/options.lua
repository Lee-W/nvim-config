-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
local opt = vim.opt

opt.langmenu = "en_US"
opt.modeline = false
opt.background = "dark"
opt.laststatus = 2 -- statusline per window (LazyVim defaults to a global one)
opt.cursorline = true -- highlight current line (replaces nvim-cursorline plugin)

-- 4-space indent (LazyVim defaults to 2; expandtab/smartindent come from LazyVim)
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.smarttab = true

---- encoding
opt.encoding = "utf-8"
opt.fileencodings = { "utf-8", "cp950", "big5" }

----Set up tab autocomplete in ex mode
opt.wildmenu = true
opt.wildmode = "full"

-- LSP Server to use for Python.
vim.g.lazyvim_python_lsp = "basedpyright"
-- Set to "ruff_lsp" to use the old LSP implementation version.
vim.g.lazyvim_python_ruff = "ruff"

vim.g.lazyvim_picker = "snacks"
