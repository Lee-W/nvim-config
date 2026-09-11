-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local map = vim.keymap.set

map("n", "<C-P>", function() Snacks.picker.files() end, { desc = "Find Files (cwd)" })

-- spell toggle: LazyVim core already binds <leader>us
-- comments: use built-in gc/gcc; ` is back to native mark jumps

map("n", "gb", "<cmd>bnext<cr>", { desc = "Next Buffer", silent = true })
map("n", "gB", "<cmd>bprevious<cr>", { desc = "Previous Buffer", silent = true })

map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })
