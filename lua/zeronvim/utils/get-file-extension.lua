-- Get the fileextension of the current file, without delimiter
local function getFileExtension()
  local extension = vim.fn.expand "%:e"
  return extension
end

return getFileExtension
