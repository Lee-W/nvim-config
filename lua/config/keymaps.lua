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

----find files (snacks picker, unified with lazyvim_picker)
map("n", "<C-P>", function() require("snacks").picker.files() end)

----toggle spell checking
map("n", "<F7>", "<cmd>setlocal spell!<cr>")

----toggle ToggleTerm
map("n", "<F8>", "<cmd>ToggleTerm<cr>")

----toogle AerialToggle[!]
map("n", "<F10>", "<cmd>AerialToggle<cr>")

----comment via built-in gc (keep the old ` muscle memory)
map("n", "`", "gcc", { remap = true })
map("x", "`", "gcgv", { remap = true })

---diagnostics
map("n", "<C-k>", function() vim.diagnostic.jump({ count = -1, float = true }) end, { silent = true })
map("n", "<C-j>", function() vim.diagnostic.jump({ count = 1, float = true }) end, { silent = true })

---buffer
map("n", "gb", ":bnext<cr>")
map("n", "gB", ":bprevious<cr>")

---terminal
map("t", "<Esc>", "<C-\\><C-n>") ---, { silent = true })
