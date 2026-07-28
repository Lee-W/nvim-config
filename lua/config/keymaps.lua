-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
--
-- This file is automatically loaded by lazyvim.plugins.config

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

----find files (snacks picker, unified with lazyvim_picker)
map("n", "<C-P>", function() require("snacks").picker.files() end)

-- spell toggle: LazyVim core already binds <leader>us
-- comments: use built-in gc/gcc; ` is back to native mark jumps

---buffer
map("n", "gb", ":bnext<cr>")
map("n", "gB", ":bprevious<cr>")

---terminal
map("t", "<Esc>", "<C-\\><C-n>") ---, { silent = true })
