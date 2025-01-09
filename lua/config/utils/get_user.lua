local M = {}

---Get the os user via the lua os module
---@return string
M.get_user = function()
  local os = require("os")
  local user = os.getenv("USER")

  if user == nil then
    error("could not retrieve user", vim.log.levels.ERROR)
  end

  return user
end

return M
