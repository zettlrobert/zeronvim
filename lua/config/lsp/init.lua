---[[
---Single source of truth for LSP wiring.
---
---The filenames in ~/.config/nvim/lsp/ drive both `vim.lsp.enable()` (here)
---and mason-lspconfig's `ensure_installed` (see lua/config/plugins/mason.lua).
---To add a server: drop a file in lsp/. To remove one: delete the file.
---
---Formatters + debug adapters live in lua/config/lsp/tools.lua because they
---have no per-server config file convention; mason-tool-installer wants a list.
---]]

local M = {}

---Scan ~/.config/nvim/lsp/ and return the list of server names with the
---.lua extension stripped. Used by this module and by mason.lua.
function M.servers_from_dir()
  local dir = vim.fn.stdpath("config") .. "/lsp"
  local names = {}
  for name, t in vim.fs.dir(dir) do
    if t == "file" and name:match("%.lua$") then
      table.insert(names, name:sub(1, -5))
    end
  end
  table.sort(names)
  return names
end

---Enable each server in isolation so a single broken lsp/<name>.lua
---(e.g. one that returns nil or throws) cannot prevent the rest from loading.
for _, name in ipairs(M.servers_from_dir()) do
  local ok, err = pcall(vim.lsp.enable, name)
  if not ok then
    vim.schedule(function()
      vim.notify(("LSP enable failed for %q: %s"):format(name, err), vim.log.levels.WARN)
    end)
  end
end

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

return M
