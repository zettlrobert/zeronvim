--- vscode-eslint
local function is_vscode_eslint_isntalled()
	return vim.fn.executable("vscode-eslint-language-server") == 1
end

if is_vscode_eslint_isntalled() == false then
	vim.notify("vscode-eslint is not installed. Please install it to enable the eslint LSP server.")
	return
end

return {
	cmd = { "eslint" },
	root_dir = { ".git", "tsconfig.base.json", ".eslintrc.json" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"svelte",
		"astro",
	},
	workingDirectory = {
		mode = "auto",
	},
	settings = {
		useFlatConfig = false, -- set if using flat config
	},
}
