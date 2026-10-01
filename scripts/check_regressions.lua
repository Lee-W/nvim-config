local function assert_equal(actual, expected, label)
  assert(
    vim.deep_equal(actual, expected),
    ("%s: expected %s, got %s"):format(label, vim.inspect(expected), vim.inspect(actual))
  )
end

local tempdir = vim.fn.tempname()
vim.fn.mkdir(tempdir, "p")
tempdir = assert(vim.uv.fs_realpath(tempdir))

-- A standalone file has no root, but should still initialize its language server.
local python = require("lazy.core.config").plugins["nvim-lspconfig"].opts.servers.basedpyright
local buf = vim.api.nvim_create_buf(true, false)
vim.api.nvim_buf_set_name(buf, tempdir .. "/standalone.py")
local called, root
python.root_dir(buf, function(value)
  called, root = true, value
end)
assert(called and root == nil, "standalone Python file must have no workspace root")
local settings =
  { python = { pythonPath = "/selected/python" }, basedpyright = { analysis = { typeCheckingMode = "basic" } } }
local client = { settings = vim.deepcopy(settings) }
python.on_init(client)
assert_equal(client.settings, settings, "standalone Python settings")

-- Keep existing interpreter selection without a local venv; prefer the workspace
-- venv when it exists, including a member with its own pyproject.toml.
client.root_dir = tempdir
python.on_init(client)
assert_equal(client.settings, settings, "workspace without a venv")
vim.fn.mkdir(tempdir .. "/.venv/bin", "p")
vim.fn.mkdir(tempdir .. "/member", "p")
vim.fn.writefile({}, tempdir .. "/uv.lock")
vim.fn.writefile({}, tempdir .. "/member/pyproject.toml")
vim.fn.writefile({}, tempdir .. "/.venv/bin/python")
vim.api.nvim_buf_set_name(buf, tempdir .. "/member/app.py")
python.root_dir(buf, function(value) root = value end)
assert_equal(root, tempdir, "uv workspace root")
python.on_init(client)
settings.python.pythonPath = tempdir .. "/.venv/bin/python"
assert_equal(client.settings, settings, "workspace venv preserves other settings")
vim.api.nvim_buf_delete(buf, { force = true })

require("lazy").load({ plugins = { "diffview.nvim" } })
local diffview = require("diffview")
local pr_callback = vim.fn.maparg("<leader>gvp", "n", false, true).callback
assert(type(pr_callback) == "function", "PR diff shortcut must be available")

-- Stub only external processes and the final view opening. Deliver responses
-- later so a synchronous implementation cannot accidentally pass these checks.
local base = string.rep("a", 40)
local query = { "gh", "pr", "view", "--json", "baseRefName,baseRefOid" }
local probe = { "git", "cat-file", "-e", base .. "^{commit}" }
local upstream = { "git", "fetch", "upstream", "main" }
local origin = { "git", "fetch", "origin", "main" }
local metadata =
  { cmd = query, result = { code = 0, stdout = vim.json.encode({ baseRefName = "main", baseRefOid = base }) } }
local present = { cmd = probe, result = { code = 0 } }
local missing = { cmd = probe, result = { code = 1 } }
local upstream_ok = { cmd = upstream, result = { code = 0 } }
local origin_ok = { cmd = origin, result = { code = 0 } }
local cases = {
  { name = "base already available", steps = { metadata, present }, opens = true },
  { name = "fetch upstream", steps = { metadata, missing, upstream_ok, present }, opens = true },
  {
    name = "successful fetch from outdated fork",
    steps = { metadata, missing, upstream_ok, missing, origin_ok, present },
    opens = true,
  },
  {
    name = "origin fallback",
    steps = {
      metadata,
      missing,
      { cmd = upstream, result = { code = 128, stderr = "no upstream" } },
      missing,
      origin_ok,
      present,
    },
    opens = true,
  },
  {
    name = "all fetches fail",
    steps = {
      metadata,
      missing,
      { cmd = upstream, result = { code = 128, stderr = "upstream unavailable" } },
      missing,
      { cmd = origin, result = { code = 128, stderr = "origin unavailable" } },
      missing,
    },
    warning = "origin unavailable",
  },
  {
    name = "fetch succeeds but base remains missing",
    steps = { metadata, missing, upstream_ok, missing, origin_ok, missing },
    warning = "PR base commit is unavailable",
  },
  {
    name = "GitHub error",
    steps = { { cmd = query, result = { code = 1, stderr = "authentication failed" } } },
    warning = "authentication failed",
  },
  { name = "query timeout", steps = { { cmd = query, result = { code = 124 } } }, warning = "timed out" },
  {
    name = "fetch timeout",
    steps = { metadata, missing, { cmd = upstream, result = { code = 124 } }, missing, origin_ok, missing },
    warning = "timed out",
  },
  { name = "missing gh", steps = { { cmd = query, error = "ENOENT: gh" } }, warning = "ENOENT: gh" },
  {
    name = "invalid JSON",
    steps = { { cmd = query, result = { code = 0, stdout = "not JSON" } } },
    warning = "invalid PR base data",
  },
  {
    name = "missing base fields",
    steps = { { cmd = query, result = { code = 0, stdout = "{}" } } },
    warning = "invalid PR base data",
  },
  { name = "cwd changes during query", steps = { metadata, present }, opens = true, change_cwd = true },
}

local system, notify, open = vim.system, vim.notify, diffview.open
local cwd = vim.fn.getcwd()
local ok, err = xpcall(function()
  for _, case in ipairs(cases) do
    local calls, opened, warnings, pending = {}, {}, {}, nil
    vim.system = function(cmd, opts, callback)
      if cmd[1] ~= "gh" and not (cmd[1] == "git" and (cmd[2] == "cat-file" or cmd[2] == "fetch")) then
        return system(cmd, opts, callback)
      end
      assert(type(callback) == "function", "PR commands must be asynchronous")
      assert(opts.timeout and opts.timeout > 0, "PR commands must have a timeout")
      assert_equal(opts.cwd, cwd, "process cwd")
      calls[#calls + 1] = cmd
      local step = assert(case.steps[#calls], "unexpected command: " .. vim.inspect(cmd))
      assert_equal(cmd, step.cmd, case.name .. " command " .. #calls)
      if step.error then
        error(step.error)
      end
      pending = { callback = callback, result = step.result }
      return {}
    end
    vim.notify = function(message, ...)
      if message:sub(1, 9) == "Diffview:" then
        warnings[#warnings + 1] = message
      else
        notify(message, ...)
      end
    end
    diffview.open = function(args) opened[#opened + 1] = args end

    pr_callback()
    assert_equal(#calls, 1, case.name .. " returns before query completion")
    assert_equal(opened, {}, case.name .. " does not open early")
    if case.change_cwd then
      vim.cmd.cd(vim.fn.fnameescape(tempdir))
    end
    assert(
      vim.wait(2000, function()
        if pending then
          local completion = pending
          pending = nil
          completion.callback(completion.result)
        end
        return #opened + #warnings > 0
      end, 5),
      case.name .. " did not finish"
    )
    vim.cmd.cd(vim.fn.fnameescape(cwd))

    local expected_commands = vim.tbl_map(function(step) return step.cmd end, case.steps)
    assert_equal(calls, expected_commands, case.name .. " command sequence")
    if case.opens then
      assert_equal(warnings, {}, case.name .. " warnings")
      assert_equal(opened, { { "-C=" .. cwd, base .. "...HEAD", "--imply-local" } }, case.name .. " view")
    else
      assert_equal(opened, {}, case.name .. " must not open a view")
      assert_equal(#warnings, 1, case.name .. " warning count")
      assert(warnings[1]:find(case.warning, 1, true), case.name .. ": " .. warnings[1])
    end
  end
end, debug.traceback)
vim.system, vim.notify, diffview.open = system, notify, open
vim.cmd.cd(vim.fn.fnameescape(cwd))
assert(ok, err)

-- Use a disposable repository so this works in CI's shallow checkout as well.
-- A space in the path also exercises Diffview's explicit repository argument.
local repo = tempdir .. "/diff repo"
vim.fn.mkdir(repo, "p")
local function git(args)
  local cmd = { "git", "-C", repo, "-c", "core.hooksPath=/dev/null", "-c", "commit.gpgsign=false" }
  vim.list_extend(cmd, args)
  local result = vim.system(cmd, { text = true }):wait(10000)
  assert(result.code == 0, result.stderr)
end
git({ "init", "-b", "main" })
vim.fn.writefile({ "before" }, repo .. "/sample.txt")
git({ "add", "sample.txt" })
git({ "-c", "user.name=Config Test", "-c", "user.email=config-test@example.invalid", "commit", "-m", "Test fixture" })
vim.fn.writefile({ "after" }, repo .. "/sample.txt")
diffview.open({ "-C=" .. repo })
local lib = require("diffview.lib")
assert(
  vim.wait(5000, function()
    local view = lib.get_current_view()
    local win = view and view.cur_layout and view.cur_layout.b
    if not (win and win.id and win.file and win.file.bufnr) then
      return false
    end
    return vim.api.nvim_buf_call(
      win.file.bufnr,
      function() return vim.fn.maparg("gw", "n", false, true).desc == "Toggle wrap (all diff windows)" end
    )
  end, 20),
  "Diffview did not attach its wrap mapping"
)

local view = lib.get_current_view()
local local_buf = view.cur_layout.b.file.bufnr
for _, side in ipairs({ "a", "b" }) do
  vim.api.nvim_set_current_win(view.cur_layout[side].id)
  local expected = not vim.wo.wrap
  vim.cmd.normal("gw")
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.wo[win].diff then
      assert_equal(vim.wo[win].wrap, expected, "gw toggles both diff panes from " .. side)
    end
  end
end
vim.cmd("DiffviewClose")
vim.api.nvim_set_current_buf(local_buf)
assert_equal(vim.fn.maparg("gw", "n"), "", "closing Diffview restores native gw")
vim.api.nvim_buf_delete(local_buf, { force = true })
print(("Regression checks: Python workspace, %d PR scenarios, Diffview mapping lifecycle: ok"):format(#cases))
