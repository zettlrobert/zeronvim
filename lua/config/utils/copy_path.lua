--[[
Copy the current buffer's path into a register (<leader>c* in keymaps.lua).

  copy_relative            relative path (as shown by `%`) → register r
  copy_absolute            absolute path                    → register a
  copy_absolute_clipboard  absolute path                    → system clipboard (+)

Buffers without a file name (scratch, [No Name]) only show a warning.
]]
local M = {}

---Copy the expanded buffer path into `register`; warn when the buffer has no name.
---@param modifier string expand() modifier for the current buffer, e.g. "%" or "%:p"
---@param register string
---@param message string notification on success
local function copy(modifier, register, message)
  local path = vim.fn.expand(modifier)
  if path == "" then
    vim.notify("Buffer has no file name, nothing copied", vim.log.levels.WARN)
    return
  end
  vim.fn.setreg(register, path)
  vim.notify(message, vim.log.levels.INFO)
end

---Relative path (as shown by `%`) to register r.
function M.copy_relative()
  copy("%", "r", "Relative buffer path set to register r")
end

---Absolute path to register a.
function M.copy_absolute()
  copy("%:p", "a", "Absolute buffer path set to register a")
end

---Absolute path to the system clipboard. Uses `%:p` directly instead of
---composing cwd + %, which produced malformed paths (e.g. `/home/x//etc/foo`)
---for buffers opened by absolute path.
function M.copy_absolute_clipboard()
  copy("%:p", "+", "Absolute buffer path set to system clipboard")
end

return M
