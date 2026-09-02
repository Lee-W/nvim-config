-- Autocmds are automatically loaded on the VeryLazy
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
--

-- Check if we need to reload the file when it changed

----disable expandtab when editing makefile
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "make" },
  callback = function() vim.opt_local.expandtab = false end,
})

----file type specific setting

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.textwidth = 88
  end,
})

-- 2-space indent for web/template filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "html",
    "htmldjango",
    "jinja",
    "handlebars",
    "handlebars.html",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "css",
  },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text" },
  callback = function() vim.opt_local.textwidth = 78 end,
})

-- DVC files are YAML
vim.filetype.add({
  filename = { ["Dvcfile"] = "yaml", ["dvc.lock"] = "yaml" },
  extension = { dvc = "yaml" },
})

---- keep split boundaries visible
-- catppuccin paints both separator groups crust, which is darker than the editor
-- background, so splits have no visible edge. custom_highlights does not help:
-- the colorscheme is applied before catppuccin's setup() runs.
local function brighten_win_separator()
  local ok, palettes = pcall(require, "catppuccin.palettes")
  local fg = ok and palettes.get_palette("mocha").overlay0 or "#6c7086"
  -- WinSeparator links to VertSplit at runtime, so both need setting
  vim.api.nvim_set_hl(0, "VertSplit", { fg = fg })
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = fg })
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = brighten_win_separator })
brighten_win_separator()

---- make diffs actually readable
-- catppuccin's diff groups are ~18% blends of its pastel accents over base,
-- which desaturates them to grey: DiffChange (#25293c) is near-invisible
-- against Normal (#1e1e2e), and DiffText (#3e4b6b) barely marks the characters
-- that actually changed. Hue-true darks at a higher saturation instead. Same
-- setup() ordering problem as above, so this goes through ColorScheme too.
--
-- These four drive Diffview as well: with enhanced_diff_hl it derives
-- DiffviewDiffAddAsDelete from DiffDelete and links the rest straight through.
local function strengthen_diff_hl()
  -- whole lines with no counterpart on the other side
  vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#1f3d2b" })
  -- bg only: Diffview copies DiffDelete's fg onto real removed-side code, so a
  -- fg here would flatten that side's syntax colours
  vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#46212f" })
  -- paired lines that differ: kept quiet so DiffText owns the attention
  vim.api.nvim_set_hl(0, "DiffChange", { bg = "#2b3044" })
  -- the changed characters themselves; one group serves both sides of the
  -- split, so a third hue rather than green or red
  vim.api.nvim_set_hl(0, "DiffText", { bg = "#4c63a0", bold = true })
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = strengthen_diff_hl })
strengthen_diff_hl()
