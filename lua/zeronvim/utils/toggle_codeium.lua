local M = {}

-- the global variable for enabling codeium is called g:codeium_enabled
M.disable = function()
  vim.api.nvim_set_var("codeium_enabled", false)
end

M.toggle_ai = function()
  local current_codeium_state = vim.api.nvim_get_var("codeium_enabled");
  vim.api.nvim_set_var("codeium_enabled", not current_codeium_state);
  vim.notify("[AI]: Codeium enabled " .. tostring(vim.api.nvim_get_var("codeium_enabled")));
end

M.toggle_codium_logging = function()
  vim.env.DEBUG_CODEIUM = vim.env.DEBUG_CODEIUM == 'trace' and nil or 'trace'
  vim.notify("[AI] Codium logging " .. tostring(vim.env.DEBUG_CODEIUM))
end

M.open_codium_log = function()
  -- path to cached codeium logs
  local path = vim.fn.stdpath("cache") .. "/codeium.log"
  vim.api.nvim_command("tabnew " .. path)

  -- WIP
  -- The plugin log is written to ~/.cache/nvim/codeium.log.
  -- You can set the logging level to one of trace, debug, info, warn, error by exporting the DEBUG_CODEIUM environment variable.
end

return M
