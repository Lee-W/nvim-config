-- Autocmds are automatically loaded on the VeryLazy
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
--

-- Check if we need to reload the file when it changed

----disable expandtab when editing makefile
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "make" },
  callback = function()
    vim.opt_local.expandtab = false
  end,
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
  pattern = { "html", "htmldjango", "jinja", "handlebars", "javascript", "css" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text" },
  callback = function()
    vim.opt_local.textwidth = 78
  end,
})

-- DVC files are YAML
vim.filetype.add({
  filename = { ["Dvcfile"] = "yaml", ["dvc.lock"] = "yaml" },
  extension = { dvc = "yaml" },
})
