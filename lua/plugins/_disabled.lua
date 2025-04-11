return {
  ---- utils
  {
    "nvim-pack/nvim-spectre",
    -- nnoremap <leader>S :lua require('spectre').open()<CR>
    -- "search current word
    -- nnoremap <leader>sw :lua require('spectre').open_visual({select_word=true})<CR>
    -- vnoremap <leader>s :lua require('spectre').open_visual()<CR>
    -- "  search in current file
    -- nnoremap <leader>sp viw:lua require('spectre').open_file_search()<cr>
    enabled = false,
  },

  ---- snippets
  {
    "SirVer/ultisnips",
    enabled = false,
  },
  {
    "honza/vim-snippets",
    enabled = false,
  },

  ---- telescope
  -- Fuzzy Finder (files, lsp, etc)
  {
    "nvim-telescope/telescope.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep",
      "sharkdp/fd",
      "nvim-treesitter/nvim-treesitter",
    },
    build = ":TSUpdate",
    keys = {
      { "<C-P>", "<cmd>Telescope find_files find_command=rg,--files,--hidden,-g,!.git<cr>" },
      { "<C-B>", "<cmd>Telescope grep_string<cr>" },
    },
    config = function()
      require("telescope").setup({
        pickers = {
          find_files = {
            hidden = true,
          },
        },
        file_ignore_patterns = {
          ".git/.*",
          ".DS_Store",
        },
      })
      require("telescope").load_extension("file_browser")
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    enabled = false,
    build = "make",
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    enabled = false,
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  --file management
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
    enabled = false,
  },
  -- syntax
  ---- python
  {
    "python-mode/python-mode",
    ft = "python",
    config = function()
      vim.g.pymode_lint = 0
      vim.g.pymode_python = "python3"
      vim.g.pymode_indent = 1
      vim.g.pymode_motion = 1
      -- vim.g.pymode_rope = 1
      vim.g.pymode_lint = 0
      vim.g.pymode_folding = 0
      vim.g.pymode_options_max_line_length = 88
    end,
    enabled = false,
  },
  {
    "mitsuhiko/vim-python-combined",
    ft = "python",
    enabled = false,
  },
  {
    "psf/black",
    ft = "python",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "python" },
        callback = function()
          vim.opt_local.completeopt = "preview"
        end,
      })
    end,
    enabled = false,
  },
}
