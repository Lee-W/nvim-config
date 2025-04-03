return {
  --------overall
  {
    "sheerun/vim-polyglot",
    enabled = false,
  },
  --------python
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
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python", --optional
    },
    ft = "python",
    branch = "regexp", -- This is the regexp branch, use this for the new version
    keys = {
      { ",v", "<cmd>VenvSelect<cr>" },
    },
    opts = {
      -- auto_refresh = true,
      enable_cached_venvs = true,
      activate_venv_in_terminal = true,
      show_telescope_search_type = true,
      notify_user_on_venv_activation = true,
      picker = "fzf-lua",
    },
    lazy = true,
    -- enabled = false,
  },
  {
    "Glench/Vim-Jinja2-Syntax",
    ft = { "html", "*.j2", "*.jinja" },
  },
  {
    "tshirtman/vim-cython",
    ft = "*pyx",
  },
  --------C/C++
  {
    "Lee-W/c.vim",
    ft = "cpp, c",
    config = function()
      vim.g.C_InsertFileHeader = "no"
      vim.g.C_CFlags = "-g -O0 -c"
      vim.g.C_LFlags = "-g -O0"
    end,
  },
  {
    "vim-jp/cpp-vim",
    ft = "cpp",
  },
  {
    "rhysd/vim-clang-format",
    ft = "cpp, c",
  },
  --------Web
  {
    "othree/html5.vim",
    ft = "html",
  },
  {
    "mattn/emmet-vim",
    ft = { "html", "css" },
  },
  {
    "othree/yajs.vim",
    ft = "javascript",
  },
  {
    "othree/javascript-libraries-syntax.vim",
    ft = "javascript",
  },
  {
    "nono/vim-handlebars",
    ft = { "html", "*.hbs", "*.handlebars" },
  },
  --------toml
  -- {
  --   "cespare/vim-toml",
  --   ft = "*.toml",
  -- },
  --------markdown
  {
    "godlygeek/tabular",
    ft = "markdown",
  },
  {
    "plasticboy/vim-markdown",
    ft = "markdown",
    config = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_conceal = 0
      vim.g.vim_markdown_conceal_code_blocks = 0
      vim.g.vim_markdown_toc_autofit = 1
    end,
  },
  ------rust
  {
    "rust-lang/rust.vim",
    ft = "rust",
  },
  ------just file
  {
    "NoahTheDuke/vim-just",
    ft = "just",
  },
}
