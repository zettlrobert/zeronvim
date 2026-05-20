--[[
Per-window heading for quickfix and location list windows. Sets the
window-local `winbar` so you can tell at a glance which list you're in:

   Quickfix · 3/12
  ──────────────────────────────
  src/foo.ts:12:5  Unused variable
  ...

Format: " {label} · {cursor_line}/{count} " or " {label} · empty ".
The cursor_line/count pair reflects the qf window's own cursor position
(what you see in the list), not :cnext's notion of "current item".

Refreshes on BufEnter / WinEnter / CursorMoved when in a qf-type window;
no-ops everywhere else so it doesn't pollute other windows' winbar.

Lualine's `winbar = {}` is empty, so we don't clash; if you later teach
lualine to render a winbar, exclude `qf` filetype from its disabled list
(or this file's behavior will win for qf windows since vim.wo.winbar is
window-local and we set it last).
]]

local function set_heading()
  local winid = vim.api.nvim_get_current_win()
  local info = vim.fn.getwininfo(winid)[1]
  if not info or info.quickfix == 0 then
    return
  end

  local is_loclist = info.loclist == 1
  local label = is_loclist and "Location list" or "Quickfix"
  local list = is_loclist and vim.fn.getloclist(winid) or vim.fn.getqflist()
  local count = #list

  local heading
  if count == 0 then
    heading = (" %s · empty "):format(label)
  else
    heading = (" %s · %d/%d "):format(label, vim.fn.line("."), count)
  end

  vim.wo.winbar = "%#QuickFixLine#" .. heading .. "%*"
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "WinEnter", "CursorMoved" }, {
  pattern = "*",
  callback = set_heading,
  group = vim.api.nvim_create_augroup("QfHeading", { clear = true }),
})
