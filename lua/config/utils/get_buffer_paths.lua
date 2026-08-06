local M = {}

---Get the current relative buffer path and set it to the r register
M.get_current_relative_buffer_path = function()
  local relative_buffer_path = vim.fn.expand("%")

  vim.fn.setreg("r", relative_buffer_path)

  vim.notify("Relative buffer path set to register r", vim.log.levels.INFO)
end

---Get the current absolute buffer path and set it to the a register
M.get_current_absolute_buffer_path = function()
  local absolute_buffer_path = vim.fn.expand("%:p")

  vim.fn.setreg("a", absolute_buffer_path)

  vim.notify("Absolute buffer path set to register a", vim.log.levels.INFO)
end

---Get the current absolute buffer path and set it to the system clipboard.
---Uses `%:p` directly instead of composing cwd + %, which produced malformed
---paths (e.g. `/home/x//etc/foo`) for buffers opened by absolute path.
M.get_current_absolute_buffer_path_with_cwd = function()
  local full_path = vim.fn.expand("%:p")

  vim.fn.setreg("+", full_path)

  vim.notify("Absolute buffer path set to system clipboard", vim.log.levels.INFO)
end

return M
