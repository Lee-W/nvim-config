return {
  --------overall
  {
    "sheerun/vim-polyglot",
    enabled = false,
  },
  --------python
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python", --optional
    },
    ft = "python",
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
    enabled = true,
  },
  {
    "Glench/Vim-Jinja2-Syntax",
    ft = { "html", "*.j2", "*.jinja" },
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
  --------markdown
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
