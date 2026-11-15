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
  local wintype = vim.fn.win_gettype(winid)
  if wintype ~= "quickfix" and wintype ~= "loclist" then
    return ""
  end

  -- { size = 0 } returns only the item count instead of copying every entry,
  -- which matters because this runs on each winbar refresh.
  local is_loclist = wintype == "loclist"
  local label = is_loclist and "Location list" or "Quickfix"
  local count = is_loclist and vim.fn.getloclist(winid, { size = 0 }).size or vim.fn.getqflist({ size = 0 }).size

  if count == 0 then
    return (" %s · empty "):format(label)
  end
  return (" %s · %d/%d "):format(label, vim.fn.line("."), count)
end

M.compute = compute

return M
