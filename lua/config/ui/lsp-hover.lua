--[[
-- BUG: This is broken
-- Ensure Hover Doc has rounded border
 ]]
vim.lsp.handlers["textDocument/hover"] = vim.lsp.buf.hover({
  border = "rounded",
})
