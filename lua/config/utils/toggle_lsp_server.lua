local M = {}

--[[
Toggle an LSP server's attach state on the current buffer. Detaches if any
client with the given name is attached; otherwise calls :LspStart to attach.
Useful as an escape hatch for noisy linters (e.g. vale-ls) when working on
documents whose style intentionally diverges from the configured rules.
]]
local toggle_lsp_server = function(name)
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr, name = name })

  if #clients > 0 then
    for _, client in ipairs(clients) do
      vim.lsp.buf_detach_client(bufnr, client.id)
    end
    vim.notify(("LSP %s: detached from buffer"):format(name), vim.log.levels.INFO)
    return
  end

  local ok, err = pcall(vim.cmd, "LspStart " .. name)
  if ok then
    vim.notify(("LSP %s: attached to buffer"):format(name), vim.log.levels.INFO)
  else
    vim.notify(("LSP %s: attach failed (%s)"):format(name, err), vim.log.levels.WARN)
  end
end

M.toggle_lsp_server = toggle_lsp_server

return M
