--- TODO: use lua to check if executagbe is availalbe
--- check for tsgo binary
local function is_tsgo_installed()
  return vim.fn.executable("tsgo") == 1
end

if is_tsgo_installed() == false then
  vim.notify("tsgo is not installed. Please install it to enable the tsgo LSP server.")
  return
end

return {
  cmd = { "tsgo --stdio" },
  root_markers = { ".git" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
}
