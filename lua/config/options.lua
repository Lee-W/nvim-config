-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
local opt = vim.opt

opt.modeline = false
opt.background = "dark"
opt.laststatus = 3 -- single global statusline keeps split-heavy views uncluttered
opt.cursorline = true -- highlight current line (replaces nvim-cursorline plugin)

-- Diff quality. Spelled out rather than appended so the whole set is visible;
-- nvim 0.12 defaults to internal,filler,closeoff,indent-heuristic,inline:char,linematch:40.
-- linematch is the budget for pairing lines inside a hunk: unpaired lines render
-- as solid add/delete blocks, and character-level highlighting only happens
-- within paired lines, so a bigger budget buys visibly finer diffs.
opt.diffopt = {
  "internal",
  "filler",
  "closeoff",
  "indent-heuristic",
  "algorithm:histogram", -- pairs moved/reordered blocks better than myers
  "inline:char", -- highlight the changed characters, not the whole line
  "linematch:60",
}

-- 4-space indent (LazyVim defaults to 2; expandtab/smartindent come from LazyVim)
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4

---- file encoding fallbacks
opt.fileencodings = { "utf-8", "cp950", "big5" }

-- LSP Server to use for Python.
vim.g.lazyvim_python_lsp = "basedpyright"
-- Set to "ruff_lsp" to use the old LSP implementation version.
vim.g.lazyvim_python_ruff = "ruff"

vim.g.lazyvim_picker = "snacks"
