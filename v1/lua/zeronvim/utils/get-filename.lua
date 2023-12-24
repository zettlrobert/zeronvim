-- Get the name of the current file, this includes the file extension
local function getFilename()
  local filename = vim.fn.expand "%:t"
  return filename
end

return getFilename
