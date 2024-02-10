-- Conceal Syntax (pretty rendering)
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.norg", "*.md" },
  command = "set conceallevel=3",
  group = vim.api.nvim_create_augroup("write_conceal", { clear = true }),
})

-- JSON files should not be concealled
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.json" },
  command = "set conceallevel=0",
  group = vim.api.nvim_create_augroup("json_conceal", { clear = true }),
})
