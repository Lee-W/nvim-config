-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
local opt = vim.opt

opt.langmenu = "en_US"
opt.syntax = "on"

opt.nu = true --  show line number
opt.cursorline = true --  show the location of cursor
opt.background = "dark"
opt.ruler = true
opt.hlsearch = true --  highlight serach reslt
opt.incsearch = true --  jump to the matching string when typing

opt.confirm = true
opt.history = 30 --  keep the latest 30 used commands
opt.laststatus = 2 --  always show the statusline

opt.autoindent = true
opt.cindent = true
opt.smartindent = true
opt.shiftwidth = 4
-- opt.backspace = 2
opt.tabstop = 4
opt.softtabstop = 4
opt.smarttab = true
opt.expandtab = true --  covert tab to space, you can use [Ctrl + V + Tab] if tab is needed
opt.hidden = true
opt.splitbelow = true
opt.splitright = true

---- encoding
opt.encoding = "utf-8"
opt.fileencodings = { "utf-8", "cp950", "big5" }

----Set up tab autocomplete in ex mode
opt.wildmenu = true
opt.wildmode = "full"
