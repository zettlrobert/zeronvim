--[[
Centralized state, actions, and statusline component for the AI providers
(Copilot + Windsurf/Codeium).

Notification format is normalized: "Copilot: enabled/disabled" and
"Windsurf: enabled/disabled" — bypassing codeium's internal "Codeium
enabled" toast to keep the branding consistent with the plugin's public
name.

Every function is pcall-guarded so calls from the statusline / keymaps
don't break if a plugin failed to load.
]]

local M = {}

-- ---------------------------------------------------------------------------
-- State queries
-- ---------------------------------------------------------------------------

function M.is_copilot_enabled()
  local ok, client = pcall(require, "copilot.client")
  if not ok then
    return false
  end
  return not client.is_disabled()
end

function M.is_windsurf_enabled()
  local ok, codeium = pcall(require, "codeium")
  if not ok then
    return false
  end
  return codeium.s ~= nil and codeium.s.enabled == true
end

-- ---------------------------------------------------------------------------
-- Copilot actions
-- ---------------------------------------------------------------------------

---@param opts? { silent?: boolean }
function M.enable_copilot(opts)
  opts = opts or {}
  local ok, cmd = pcall(require, "copilot.command")
  if not ok then
    return
  end
  cmd.enable()
  if not opts.silent then
    vim.notify("Copilot: enabled", vim.log.levels.INFO)
  end
end

---@param opts? { silent?: boolean }
function M.disable_copilot(opts)
  opts = opts or {}
  local ok, cmd = pcall(require, "copilot.command")
  if not ok then
    return
  end
  cmd.disable()
  if not opts.silent then
    vim.notify("Copilot: disabled", vim.log.levels.INFO)
  end
end

function M.toggle_copilot()
  if M.is_copilot_enabled() then
    M.disable_copilot()
  else
    M.enable_copilot()
  end
end

-- ---------------------------------------------------------------------------
-- Windsurf actions
-- ---------------------------------------------------------------------------

-- Set enabled directly on the server table instead of calling
-- codeium.enable/disable — those emit their own "Codeium enabled" notify
-- which conflicts with the "Windsurf: enabled" branding.

---@param opts? { silent?: boolean }
function M.enable_windsurf(opts)
  opts = opts or {}
  local ok, codeium = pcall(require, "codeium")
  if not ok or not codeium.s then
    return
  end
  codeium.s.enabled = true
  if not opts.silent then
    vim.notify("Windsurf: enabled", vim.log.levels.INFO)
  end
end

---@param opts? { silent?: boolean }
function M.disable_windsurf(opts)
  opts = opts or {}
  local ok, codeium = pcall(require, "codeium")
  if not ok or not codeium.s then
    return
  end
  codeium.s.enabled = false
  if not opts.silent then
    vim.notify("Windsurf: disabled", vim.log.levels.INFO)
  end
end

function M.toggle_windsurf()
  if M.is_windsurf_enabled() then
    M.disable_windsurf()
  else
    M.enable_windsurf()
  end
end

-- ---------------------------------------------------------------------------
-- Combined
-- ---------------------------------------------------------------------------

-- Master toggle: if any provider is on → disable both. If both off → enable
-- both. One combined notification instead of two individual ones.
function M.toggle_all()
  local any_on = M.is_copilot_enabled() or M.is_windsurf_enabled()
  if any_on then
    M.disable_copilot({ silent = true })
    M.disable_windsurf({ silent = true })
    vim.notify("AI: all disabled", vim.log.levels.INFO)
  else
    M.enable_copilot({ silent = true })
    M.enable_windsurf({ silent = true })
    vim.notify("AI: all enabled", vim.log.levels.INFO)
  end
end

-- Called once at startup from each plugin's config to default both off.
function M.startup_disable_all()
  M.disable_copilot({ silent = true })
  M.disable_windsurf({ silent = true })
end

-- ---------------------------------------------------------------------------
-- Statusline
-- ---------------------------------------------------------------------------

-- Compact indicator: "AI C+W" / "AI C" / "AI W" / "AI off".
function M.statusline()
  local c = M.is_copilot_enabled()
  local w = M.is_windsurf_enabled()
  if not c and not w then
    return "AI off"
  end
  local marks = {}
  if c then
    table.insert(marks, "C")
  end
  if w then
    table.insert(marks, "W")
  end
  return "AI " .. table.concat(marks, "+")
end

return M
