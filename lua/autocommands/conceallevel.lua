-- Conceal Syntax (pretty rendering)
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.norg", "*.md" },
  command = "set conceallevel=3"
})
