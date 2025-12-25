--- check for vtsls binary
local function is_vtsls_installed()
	return vim.fn.executable("vtsls") == 1
end

if is_vtsls_installed() == false then
	vim.notify(
		"vtsls is not installed. Please install it to enable the vtsls LSP server. https://github.com/yioneko/vtsls",
		vim.log.levels.ERROR
	)
	return
end

return {
	cmd = { "vtsls --stdio" },
	root_markers = { ".git" },
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
}
