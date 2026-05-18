local M = {}

--[[
Toggle an LSP server's attach state on the current buffer. Detaches if any
client with the given name is attached; otherwise calls vim.lsp.start with
the registered config to attach (reusing the running client if present).
Useful as an escape hatch for noisy linters (e.g. vale-ls) when working on
documents whose style intentionally diverges from the configured rules.
]]
local toggle_lsp_server = function(name)
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr, name = name })
  local title = "LSP toggle"

  if #clients > 0 then
    for _, client in ipairs(clients) do
      vim.lsp.buf_detach_client(bufnr, client.id)
    end
    vim.notify(("%s: detached from buffer"):format(name), vim.log.levels.INFO, { title = title })
    return
  end

  -- Resolve the merged config (nvim-lspconfig defaults + user override from
  -- lsp/<name>.lua). vim.lsp.start reuses the running client (matched on name
  -- + root_dir) and attaches it to bufnr — :LspStart alone wouldn't re-attach
  -- because the client is already running globally after a detach.
  local config = vim.lsp.config[name]
  if not config then
    vim.notify(("%s: no config registered"):format(name), vim.log.levels.WARN, { title = title })
    return
  end

  local final_config = vim.tbl_deep_extend("force", config, { name = name })
  local ok, client_id = pcall(vim.lsp.start, final_config, { bufnr = bufnr })
  if ok and client_id then
    vim.notify(("%s: attached to buffer"):format(name), vim.log.levels.INFO, { title = title })
  else
    vim.notify(
      ("%s: attach failed (%s)"):format(name, ok and "no client id returned" or tostring(client_id)),
      vim.log.levels.WARN,
      { title = title }
    )
  end
end

M.toggle_lsp_server = toggle_lsp_server

return M
