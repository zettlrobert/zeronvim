local M = {}

-- Convert a table to a string for debugging purposes
local function table_to_string(t)
  local str = "{"
  for i, v in ipairs(t) do
    if type(v) == "table" then
      str = str .. table_to_string(v)
    else
      str = str .. tostring(v)
    end
    if i < #t then
      str = str .. ", "
    end
  end
  str = str .. "}"
  return str
end

-- Assert the type of a value
M.assert_debug_value_type = function(debugValue)
  return type(debugValue)
end

-- Parse a value into a string to make it printable
M.parse_debug_value = function(type, value)
  if type == "string" then
    return value
  end

  if type == "table" then
    local stringified_value = table_to_string(value)
    return stringified_value
  end

  if type == "number" then
    local stringified_value = tostring(value)
    return stringified_value
  end

  if type == "boolean" then
    local stringified_value = tostring(value)
    return stringified_value
  end

  return "Error: Custom debugger currently does not support this type"
end

-- Custom debugger to print out values
M.log = function(identifier, debugValue)
  local debug_value_type = M.assert_debug_value_type(debugValue)
  local parsed_debug_value = M.parse_debug_value(debug_value_type, debugValue)

  vim.api.nvim_command("echo '" .. identifier .. ' ' .. parsed_debug_value .. "'")
end

return M
