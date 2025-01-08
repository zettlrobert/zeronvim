local M = {}

-- get the os user via the lua os module
M.get_user = function()
  local os = require("os")
  local user = os.getenv("USER")
  return user
end

return M
