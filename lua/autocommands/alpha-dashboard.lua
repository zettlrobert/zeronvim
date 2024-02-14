-- Check nvim argv and open dashboard if current location (.) or nothing was provided
local open_dashboard = function()
  local neovim_arguments = vim.fn.argv()

  if neovim_arguments[1] == "." or neovim_arguments == nil then
    vim.api.nvim_command(":Alpha")
  end
end

-- Autocommand to display the Dashboard on `VimEnter`
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  group = vim.api.nvim_create_augroup("Dashboard", { clear = true }),
  callback = function()
    open_dashboard()
  end,
})
