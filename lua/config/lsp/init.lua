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

---Enable LSP Completion. Guard against a nil client — get_client_by_id can
---return nil if the client stopped between LspAttach firing and this callback.
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

---Rounded borders across LSP floats + diagnostic float. Matches the aesthetic
---already used by dap-ui and snacks components — one consistent look for all
---floating popups. Covers hover (`K`), signature help, and diagnostic float
---(`vim.diagnostic.open_float`, `<leader>d`).
---
---Neovim 0.12 deprecated `vim.lsp.with()`; we wrap the buf functions instead
---to inject `border = "rounded"` on every invocation.
vim.diagnostic.config({
  float = { border = "rounded" },
})
local orig_hover = vim.lsp.buf.hover
vim.lsp.buf.hover = function(opts)
  return orig_hover(vim.tbl_extend("force", { border = "rounded" }, opts or {}))
end
local orig_sig = vim.lsp.buf.signature_help
vim.lsp.buf.signature_help = function(opts)
  return orig_sig(vim.tbl_extend("force", { border = "rounded" }, opts or {}))
end

local kd = require("config.utils.keymap_desc")
local K, T = kd.KIND, kd.TOOL

vim.keymap.set("n", "<leader>lc", vim.lsp.buf.code_action, {
  desc = kd.format(K.EDIT, T.LSP, "code action (direct)"),
})

---Diagnostics
vim.diagnostic.config({
  virtual_text = { current_line = true },
  virtual_lines = { current_line = true },
  signs = true,
  underline = true,
})

-- Global Diagnostics Keybinds
-- [d/]d are Neovim 0.12 defaults using vim.diagnostic.jump; we deliberately
-- don't override them here. Our previous overrides called get_next/get_prev
-- which return diagnostic data but don't move the cursor.
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {
  desc = kd.format(K.SHOW, T.Diagnostic, "float at cursor"),
})
vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, {
  desc = kd.format(K.EDIT, T.Diagnostic, "populate loclist"),
})

return M
