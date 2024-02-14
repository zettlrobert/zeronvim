-- Autocommand to display the Dashboard on `VimEnter`
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  command = ":Alpha",
  group = vim.api.nvim_create_augroup("Dashboard", { clear = true }),
})
