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
  pattern = { "python" },
  callback = function()
    vim.opt_local.omnifunc = "python3complete#Complete"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.textwidth = 88
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "*.hbs", "*.handlebars" },
  callback = function()
    vim.opt_local.filetype = "html.jinja"
    vim.opt_local.ts = 2
    vim.opt_local.sts = 2
    vim.opt_local.sw = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "javascript" },
  callback = function()
    vim.opt_local.ts = 2
    vim.opt_local.sts = 2
    vim.opt_local.sw = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "Dvcfile", "*.dvc", "dvc.lock" },
  callback = function()
    vim.setfiletype = "yaml"
  end,
})

vim.api.nvim_create_autocmd("BufRead", {
  pattern = { "*.txt" },
  callback = function()
    vim.textwidth = 78
  end,
})
