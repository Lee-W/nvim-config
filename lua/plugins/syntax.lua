return {
  --------overall
  {
    "w0rp/ale",
    config = function()
      vim.g.ale_linters.python = { "flake8", "mypy", "bandit" }
      vim.g.ale_lint_on_enter = 0
      vim.g.ale_lint_on_text_changed = "never"
      vim.g.ale_linters_explicit = 1

      local fixers = {}
      fixers["*"] = { "remove_trailing_lines", "trim_whitespace" }
      fixers["python"] = { "black", "isort", "ruff" }
      vim.g.ale_fixers = fixers
      vim.g.ale_fix_on_save = 1
      vim.g.ale_python_isort_options = "--profile black"
      vim.g.ale_python_bandit_options = "-iii -lll -s=B322"
      vim.g.ale_python_flake8_options = "--ignore=W503,E501,F632,E203 --max-line-length=88"
      vim.g.ale_python_mypy_options = "--ignore-missing-imports"
      vim.g.ale_python_auto_pipenv = 1
      vim.g.ale_yaml_yamllint_options = "-d relaxed"
      vim.g.ale_open_list = 1
      vim.g.ale_list_window_size = 6
    end,
  },
  {
    "sheerun/vim-polyglot",
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
  },
  {
    "mitsuhiko/vim-python-combined",
    ft = "python",
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
  {
    "elzr/vim-json",
    ft = "json",
  },
  --------YAML
  {
    "stephpy/vim-yaml",
    ft = "yaml",
  },
  --------toml
  {
    "cespare/vim-toml",
    ft = "*.toml",
  },
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
}
