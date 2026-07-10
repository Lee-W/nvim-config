local root = vim.fn.getcwd()
local files = vim.fn.globpath(root, "**/*.lua", false, true)

assert(#files > 0, "no Lua files found")

for _, file in ipairs(files) do
  local chunk, err = loadfile(file)
  assert(chunk, ("failed to parse %s:\n%s"):format(file, err))
end

print(("Lua syntax: %d files checked"):format(#files))
