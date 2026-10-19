-- Leaves evidence when a synchronous vim.wait() never comes back.
--
-- A wait that blocks for good can't report itself, so the wrapper only keeps an
-- in-memory stack of the waits currently open; a libuv timer (which vim.wait
-- keeps servicing) dumps that stack to stdpath("state") once the oldest open
-- wait is older than THRESHOLD_MS. Nothing is written on the normal path.
local THRESHOLD_MS = 5000

local uv = vim.uv
local orig_wait = vim.wait
local open = {}
local dumped = false

local function dump()
  local path = ("%s/stuck-wait-%d.log"):format(vim.fn.stdpath("state"), uv.os_getpid())
  local f = io.open(path, "w")
  if not f then
    return
  end
  local now = uv.hrtime()
  f:write(("%s: %d wait(s) open, oldest %.1fs\n"):format(os.date("%F %T"), #open, (now - open[1].t0) / 1e9))
  for i, w in ipairs(open) do
    f:write(("\n#%d timeout=%s open=%.1fs\n%s\n"):format(i, tostring(w.timeout), (now - w.t0) / 1e9, w.tb))
  end
  f:close()
  dumped = true
end

local timer = uv.new_timer()
timer:unref()
timer:start(2000, 2000, function()
  if not dumped and open[1] and (uv.hrtime() - open[1].t0) / 1e6 > THRESHOLD_MS then
    dump()
  end
end)

---@diagnostic disable-next-line: duplicate-set-field
vim.wait = function(timeout, ...)
  local depth = #open + 1
  open[depth] = { t0 = uv.hrtime(), timeout = timeout, tb = debug.traceback("", 2) }
  local ok, a, b = pcall(orig_wait, timeout, ...)
  open[depth] = nil
  if not ok then
    error(a, 0)
  end
  return a, b
end
