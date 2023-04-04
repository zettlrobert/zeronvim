local M = {}

M.get_file_icon = function(current_file, current_file_type)
  local file_icon, _ = require("nvim-web-devicons").get_icon(current_file, current_file_type, { default = true })
  if file_icon == nil then
    return ""
  end
  return file_icon
end

return M
