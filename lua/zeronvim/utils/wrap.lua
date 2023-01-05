local M = {}

M.toggle_wrap = function()
  local wrap = vim.api.nvim_get_option_value("wrap", {})
  local linebreak = vim.api.nvim_get_option_value("linebreak", {})

  if not wrap and not linebreak then
    vim.notify("Wrapping...")
    vim.api.nvim_set_option_value("wrap", not wrap, {})
    vim.api.nvim_set_option_value("linebreak", not linebreak, {})
  else
    vim.notify("[Error]: can not toggle wrap \n" .. "wrap set to: " .. tostring(wrap) .. " linebreak set to: " .. tostring(linebreak))
  end

  if wrap and linebreak then
    vim.notify("Disable Wrapping...")
    vim.api.nvim_set_option_value("wrap", not wrap, {})
    vim.api.nvim_set_option_value("linebreak", not linebreak, {})
    return
  end
end

return M
