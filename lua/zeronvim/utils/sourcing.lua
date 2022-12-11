-- TODO: Double Check that sourcing is working
local function source_nvim_configuration()
  local vimRCPath = vim.env.MYVIMRC
  local command = "source" .. vimRCPath

  local status_ok = pcall(vim.api.nvim_command, command)
  if not status_ok then
    vim.notify("[FAIL]: nvim configuration NOT sourced")
    return
  end
  vim.notify("[OK]: nvim configuration sourced")
end

return source_nvim_configuration
