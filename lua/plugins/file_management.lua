local function getTelescopeOpts(state, path)
  return {
    cwd = path,
    search_dirs = { path },
    attach_mappings = function(prompt_bufnr, map)
      local actions = require("telescope.actions")
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local action_state = require("telescope.actions.state")
        local selection = action_state.get_selected_entry()
        local filename = selection.filename
        if filename == nil then
          filename = selection[1]
        end
        -- any way to open the file without triggering auto-close event of neo-tree?
        require("neo-tree.sources.filesystem").navigate(state, state.path, filename)
      end)
      return true
    end,
  }
end

return {
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        filters = {
          custom = {
            "^\\.git$",
            ".mypy_cache",
            ".pytest_cache",
            ".ropeproject",
            "__pycache__",
            ".ipynb_checkpoints",
            ".hypothesis",
          },
        },
        git = { ignore = false },
      })
    end,
    keys = {
      { "<F2>", "<cmd>NvimTreeToggle<cr>" },
    },
    enabled = false,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        window = {
          width = 33,
        },
        enable_git_status = true,
        enable_diagnostics = true,
        filesystem = {
          filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = false,
            hide_gitignored = false,
            never_show = {
              ".git",
              ".mypy_cache",
              ".pytest_cache",
              ".ruff_cache",
              ".ropeproject",
              "__pycache__",
              ".ipynb_checkpoints",
              ".hypothesis",
            },
          },
        },
      })
    end,
    keys = {
      { "<F2>", "<cmd>Neotree toggle<cr>" },
    },
  },
}
