local M = {}

--- Return the path to a local system binary via luo io.popen or nil if unavailable
---@param binary string
---@return string
M.get_system_binary = function(binary)
  local handle = io.popen("whereis " .. binary)

  if handle then
    local binary_path = handle:read("*a")
    handle:close()

    -- Trim white space
    binary_path = binary_path:gsub("^%s*(.-)%s*$", "%1")

    if binary_path == "" then
      error("Could not find system binary: " .. binary, vim.log.levels.WARN)
    end

    return binary_path
  end
end

return M
