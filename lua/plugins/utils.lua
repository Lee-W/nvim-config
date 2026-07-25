return {
  {
    -- nvim API + plugin types for lua_ls (kills the "Undefined global vim" warnings)
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "lazy.nvim", words = { "LazyVim" } },
      },
    },
  },
  {
    -- project-wide find & replace UI
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    opts = { headerMaxWidth = 80 },
    keys = {
      {
        "<leader>sR",
        function() require("grug-far").open() end,
        desc = "Find & replace (grug-far)",
      },
    },
  },
  {
    -- code outline window
    "stevearc/aerial.nvim",
    keys = {
      { "<F10>", "<cmd>AerialToggle<cr>", desc = "Toggle code outline" },
    },
    opts = {
      layout = {
        default_direction = "prefer_right",
      },
    },
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "tpope/vim-repeat",
    event = "VeryLazy",
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    event = "BufReadPost",
    config = function()
      vim.o.foldcolumn = "0"
      -- ufo owns folding: keep every fold open on entry and let ufo (not LazyVim's
      -- native vim.lsp.foldexpr) decide the provider, otherwise the two disagree
      -- and the virtual fold text drifts out of sync with the real fold state.
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" 󰁂 %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end

      require("ufo").setup({
        fold_virt_text_handler = handler,
        provider_selector = function() return { "lsp", "indent" } end,
      })

      -- Built-in zR/zM only see the folds vim computed; ufo keeps its own state.
      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
    end,
  },
  {
    -- easier search
    "kevinhwang91/nvim-hlslens",
    event = "VeryLazy",
    config = function() require("hlslens").setup() end,
  },
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<F8>",
        function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end,
        mode = { "n", "t" },
        desc = "Terminal (Root Dir)",
      },
    },
  },
  -- marks.nvim removed: its whole value is ` -prefixed mark navigation, which
  -- config/keymaps.lua trades away by mapping ` to gcc. Use 'a to jump instead.
  -- included in lazyvim (customize behavior)
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = { max_lines = 3 },
  },
  {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      -- Add languages to be installed here that you want installed for treesitter
      vim.list_extend(opts.ensure_installed, {
        "c",
        "lua",
        "python",
        "json",
        "just",
        "query",
        "vim",
        "yaml",
        "markdown",
        "bash",
        "diff",
        "html",
        "css",
        "jinja",
        "jinja_inline",
      })
      -- indent = { enable = true, disable = { "python" } },
    end,
  },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          jump_labels = true,
        },
      },
    },
  },
}
