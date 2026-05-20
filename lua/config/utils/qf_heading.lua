local M = {}

--[[
Compute the heading string shown in the winbar of quickfix and location
list windows. Format: " Quickfix · 3/12 " or " Location list · empty ".

Returns "" when called from a non-qf window so it can be safely wired into
lualine's global winbar config (which fires across all windows).

The cursor_line/count pair reflects the qf window's own cursor position
(what you see in the list).

Known caveat: lualine refreshes winbar on every CursorMoved event, which
causes a brief visible flicker on j/k. The flicker is the cost of having
live position info. To eliminate it we'd need to bypass lualine entirely
for winbar (separate refactor).
]]
local function compute()
  local winid = vim.api.nvim_get_current_win()
  local info = vim.fn.getwininfo(winid)[1]
  if not info or info.quickfix == 0 then
    return ""
  end

  local is_loclist = info.loclist == 1
  local label = is_loclist and "Location list" or "Quickfix"
  local list = is_loclist and vim.fn.getloclist(winid) or vim.fn.getqflist()
  local count = #list

  if count == 0 then
    return (" %s · empty "):format(label)
  end
  return (" %s · %d/%d "):format(label, vim.fn.line("."), count)
end

M.compute = compute

return M
