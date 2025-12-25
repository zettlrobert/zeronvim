---[[
---Auto enable all configured LSP servers.
---The name of the server corresponds with the filename in the `lsp/` directory.
---]]
vim.lsp.enable({
	"lua_ls",
	"tofu_ls",
	"vtsls",
})

---Enable LSP Completion
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})

vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })

---Diagnostics
vim.diagnostic.config({
	virtual_text = { current_line = true },
	virtual_lines = { current_line = true },
	signs = true,
	underline = true,
})

-- Global Diagnostics Keybinds
vim.keymap.set("n", "<space>d", vim.diagnostic.open_float, { desc = "Diagnostics open floating window" })
vim.keymap.set("n", "[d", vim.diagnostic.get_next, { desc = "Diagnostics get_next" })
vim.keymap.set("n", "]d", vim.diagnostic.get_prev, { desc = "Diagnostics get_prev" })
vim.keymap.set("n", "<space>lq", vim.diagnostic.setloclist, { desc = "Diagnostics set loclist" })
