vim.api.nvim_create_autocmd({ "VimEnter" }, {
  command = "SpellCheckEnglish",
  group = vim.api.nvim_create_augroup("SpellCheck", { clear = true}),
})
