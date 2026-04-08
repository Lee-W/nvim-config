return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    lazy = false,
    opts = {
      -- Focus Claude terminal after sending code/selection
      focus_after_send = true,
      -- Diff opens in a new tab with terminal hidden for more review space
      diff_opts = {
        open_in_new_tab = true,
        keep_terminal_focus = false,
      },
      terminal = {
        split_side = "right",
        split_width_percentage = 0.4,
      },
    },
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      -- Core toggle/navigation
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ao", "<cmd>ClaudeCodeOpen<cr>", desc = "Open Claude" },
      { "<leader>aq", "<cmd>ClaudeCodeClose<cr>", desc = "Close Claude" },
      { "<leader>ai", "<cmd>ClaudeCodeStatus<cr>", desc = "Claude status" },
      -- Session management
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select model" },
      -- Context: add current buffer (normal) or send selection (visual)
      { "<leader>as", "<cmd>ClaudeCodeAdd %<cr>", mode = "n", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file from tree",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
}
