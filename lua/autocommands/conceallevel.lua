-- Conceal Syntax (pretty rendering)
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.norg" },
  command = "set conceallevel=3",
  group = vim.api.nvim_create_augroup("write_conceal", { clear = true }),
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.md" },
  command = "set conceallevel=2",
  group = vim.api.nvim_create_augroup("markdown_no_conceal", { clear = true }),
})

-- JSON files should not be concealed
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.json" },
  command = "set conceallevel=0",
  group = vim.api.nvim_create_augroup("json_conceal", { clear = true }),
})
