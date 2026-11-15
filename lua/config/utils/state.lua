--[[
Small JSON state files under stdpath("state") (~/.local/state/nvim/).

  local state = require("config.utils.state")
  local data = state.read("lsp-toggles") or {}
  state.write("lsp-toggles", data)

Reads are best-effort: a missing, empty or corrupt file returns nil. Writes go
to a temp file that is renamed over the target, so a crash mid-write never
leaves a half-written file; a failed write is reported once via vim.notify.
]]
local M = {}

---@param name string file name without the .json extension
---@return string
function M.path(name)
  return vim.fs.joinpath(vim.fn.stdpath("state"), name .. ".json")
end

---@param name string
---@return table|nil
function M.read(name)
  local f = io.open(M.path(name), "r")
  if not f then
    return nil
  end
  local content = f:read("*a")
  f:close()
  if not content or content == "" then
    return nil
  end
  local ok, parsed = pcall(vim.json.decode, content)
  return (ok and type(parsed) == "table") and parsed or nil
end

---@param name string
---@param data table
---@return boolean ok
function M.write(name, data)
  local path = M.path(name)
  local tmp = path .. ".tmp"
  local function fail(err)
    vim.notify(("Could not save %s: %s"):format(path, err), vim.log.levels.WARN)
    return false
  end

  vim.fn.mkdir(vim.fs.dirname(path), "p")
  local f, open_err = io.open(tmp, "w")
  if not f then
    return fail(open_err)
  end
  local written, write_err = f:write(vim.json.encode(data))
  f:close()
  if not written then
    os.remove(tmp)
    return fail(write_err)
  end
  local renamed, rename_err = os.rename(tmp, path)
  if not renamed then
    os.remove(tmp)
    return fail(rename_err)
  end
  return true
end

return M
