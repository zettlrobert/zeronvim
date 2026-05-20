local M = {}

--[[
Toggle an LSP server's attach state. Once toggled OFF, the server stays
detached for the rest of the session — across :e, across new buffers,
across new file opens. Toggling ON re-enables auto-attach for new buffers
that match and immediately attaches to the current buffer.

State is session-only (cleared on nvim restart). One flag per server:
disabled[server_name] = true means "user wants this off everywhere".

A LspAttach autocmd detaches any client of a disabled server the moment
it tries to attach. That's the bit that makes "open new file" not silently
revive a server you turned off.

Useful as an escape hatch for noisy linters (e.g. vale-ls) when you don't
want them anywhere in your current session.
]]

-- disabled[server_name] = true means user toggled it off
local disabled = {}

-- Re-apply the disabled state on every LSP attach. This is what makes the
-- toggle stick across :e and across newly-opened files — without it the
-- FileType-driven auto-attach would silently undo the toggle.
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("ToggleLspServerPersistDisabled", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and disabled[client.name] then
      vim.lsp.buf_detach_client(ev.buf, client.id)
    end
  end,
})

local toggle_lsp_server = function(name)
  local bufnr = vim.api.nvim_get_current_buf()
  local title = "LSP toggle"

  if disabled[name] then
    -- Currently disabled → re-enable globally and attach to current buffer
    disabled[name] = nil

    local config = vim.lsp.config[name]
    if not config then
      vim.notify(("%s: no config registered"):format(name), vim.log.levels.WARN, { title = title })
      return
    end

    local final_config = vim.tbl_deep_extend("force", config, { name = name })
    local ok, client_id = pcall(vim.lsp.start, final_config, { bufnr = bufnr })
    if ok and client_id then
      vim.notify(("%s: enabled (will attach on new buffers)"):format(name), vim.log.levels.INFO, { title = title })
    else
      vim.notify(
        ("%s: enabled but attach failed (%s)"):format(name, ok and "no client id returned" or tostring(client_id)),
        vim.log.levels.WARN,
        { title = title }
      )
    end
    return
  end

  -- Currently enabled → disable globally and detach from every attached buffer
  disabled[name] = true

  for _, client in ipairs(vim.lsp.get_clients({ name = name })) do
    for attached_bufnr in pairs(client.attached_buffers or {}) do
      vim.lsp.buf_detach_client(attached_bufnr, client.id)
    end
  end

  vim.notify(("%s: disabled (won't attach to new buffers)"):format(name), vim.log.levels.INFO, { title = title })
end

M.toggle_lsp_server = toggle_lsp_server

return M
