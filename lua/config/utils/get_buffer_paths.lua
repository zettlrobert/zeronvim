local M = {}

---Get the current relative buffer path and set it to the r register
M.get_current_relative_buffer_path = function()
  local relative_buffer_path = vim.fn.expand("%")

  vim.fn.setreg("r", relative_buffer_path)

  vim.notify("Relative buffer path set to register r", vim.log.levels.INFO)
end

---Get the current absolut buffer path and set it to the a register
M.get_current_absolute_buffer_path = function()
  local absolute_buffer_path = vim.fn.expand("%:p")

  vim.fn.setreg("a", absolute_buffer_path)

  vim.notify("Absolute buffer path set to register a", vim.log.levels.INFO)
end

---Get the current absolute buffer path and the current working directory, concatenate them, and set it to the y register  (system clipboard)
M.get_current_absolute_buffer_path_with_cwd = function()
  local current_working_directory = vim.fn.getcwd()
  local full_path = current_working_directory .. "/" .. vim.fn.expand("%")

  vim.fn.setreg("+", full_path)

  vim.notify("Full buffer path with CWD set to system clipboard", vim.log.levels.INFO)
end

return M
