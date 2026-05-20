local M = {}

--[[
Compute the heading string shown in the winbar of quickfix and location
list windows. Format: " Quickfix · 12 items " or " Location list · empty ".

Returns "" when called from a non-qf window so it can be safely wired into
lualine's global winbar config (which fires across all windows).

Intentionally does NOT include the cursor-line position. Lualine re-renders
winbar on every CursorMoved event — if the content changes per-keystroke we
get visible flicker. The statusline already shows the cursor's line number,
so the winbar's job is just "which list am I looking at?" — stable text
that only changes when the list itself changes.
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
  return (" %s · %d items "):format(label, count)
end

M.compute = compute

return M
