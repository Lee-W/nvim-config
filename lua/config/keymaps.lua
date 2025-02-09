-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
--
-- This file is automatically loaded by lazyvim.plugins.config

local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

----rename
-- map("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")

----toggl TaskList
map("n", "<F3>", "<cmd>ToggleTaskList<cr>")

----toggle spell checking
map("n", "<F7>", "<cmd>setlocal spell!<cr>")

----toggle ALE
-- map("n", "<F8>", "<cmd>ALEToggle<cr>")

----toogle tagbar
map("n", "<F10>", "<cmd>TagbarToggle<cr>")

----tcomment
map("n", "`", "<cmd>TComment<cr>")
map("v", "`", ":TComment<cr>gv")

---ale
map("n", "<C-k>", "<Plug>(ale_previous_wrap)", { silent = true })
map("n", "<C-j>", "<Plug>(ale_next_wrap)", { silent = true })

---buffer
map("n", "gb", ":BufferNext<cr>") ---, { silent = true })
map("n", "gB", ":BufferPrevious<cr>") ---, { silent = true })
map("n", "gB", ":BufferPrevious<cr>") ---, { silent = true })

---terminal
map("t", "<Esc>", "<C-\\><C-n>") ---, { silent = true })
