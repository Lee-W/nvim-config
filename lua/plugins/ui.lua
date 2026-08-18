return {
  {
    "Lee-W/ring.nvim",
    opts = {},
    config = function(_, opts)
      local ring = require("ring")
      ring.setup(opts) -- also starts the poll timer

      -- The status line only ever paints a count in the corner, which is easy to
      -- miss while typing. Announce the rising edge through vim.notify so a
      -- session that starts waiting actually reaches you, without polling twice:
      -- this only reads the state ring.nvim is already refreshing.
      local interval = ring.get_config().interval
      if interval > 0 then
        local last = ring.get_state().waiting or 0
        local timer = assert(vim.uv.new_timer())
        timer:start(
          interval,
          interval,
          vim.schedule_wrap(function()
            local waiting = ring.get_state().waiting or 0
            if waiting > last then
              vim.notify(
                ("%d session%s waiting"):format(waiting, waiting > 1 and "s" or ""),
                vim.log.levels.INFO,
                { title = "RiNG" }
              )
            end
            last = waiting
          end)
        )
        vim.api.nvim_create_autocmd("VimLeavePre", {
          callback = function()
            timer:stop()
            timer:close()
          end,
        })
      end
    end,
  },
  {
    -- included in lazyvim (customize behavior)
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.theme = "auto"
      vim.list_extend(opts.extensions, { "nvim-tree", "fugitive" })
      table.insert(opts.sections.lualine_x, 1, "ring")
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
  },
  -- cursorline: built-in vim.opt.cursorline (see config/options.lua); cursorword via illuminate
  -- included in lazyvim (customize behavior)
  { "nvim-mini/mini.ai", version = "*", opts = { n_lines = 1000 } },
}
