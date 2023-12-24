-- Get the name of the specified binary on the UNIX like operationg system
local function getSystemBinary(binary)
  local handle = io.popen("whereis " .. binary)

  if handle then
    local binaryPath = handle:read("*a")
    handle:close()

    -- Trim whitespace from the result (if necessary)
    binaryPath = binaryPath:gsub("^%s*(.-)%s*$", "%1")

    -- Retrurn nil if binary not found
    if binaryPath == "" then
      vim.notify_once("could not find system binary" .. binary)
      return nil
    end

    -- print("Path to 'uname' binary: " .. result)
    return binaryPath
  end
end

return getSystemBinary
