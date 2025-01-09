local M = {}

---Set a global editor variable
---@param name string
---@param value string|boolean
M.set_global_variable = function(name, value)
  vim.g[name] = value
end

---Returns a boolean value if a global editor variable is present or not
---@param name string
---@param[quite=false] quite boolean
---@return boolean
M.is_global_variable_set = function(name, quite)
  quite = quite or false
  local set_variable = vim.g[name]


  if set_variable == nil then
    if quite == false then
      print(name .. " NOT set")
    end

    return false
  end

  if quite == false then
    print(name .. " is set")
  end

  return true
end

---Unset a global editor variable if it was set
---@param name string
M.unset_global_variable = function(name)
  local is_set = M.is_global_variable_set(name, true)

  if is_set then
    --[[
    -- Note that setting dictionary fields directly will not write them back into Nvim.
    -- This is because the index into the namespace simply returns a copy.
    -- Instead the whole dictionary must be written as one.
    -- This can be achieved by creating a short-lived temporary.
    -- The same applies for primitive values
    ]]
    local temp_variable = vim.g[name]
    temp_variable = nil
    vim.g[name] = temp_variable
  end
end

return M
