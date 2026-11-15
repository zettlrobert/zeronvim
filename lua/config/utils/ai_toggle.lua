--[[
Centralized state, actions, and statusline component for the AI providers
(Copilot + Minuet).

Notification format is normalized: "Copilot: enabled/disabled" and
"Minuet: enabled/disabled".

Every function is pcall-guarded so calls from the statusline / keymaps
don't break if a plugin failed to load.

Lazy loading: both plugins are `lazy = true` and only load when a
provider is first enabled. A provider whose plugin is not loaded counts as
off, and the state queries never `require` it, so the statusline does not
pull a plugin in. Each plugin's config still defaults itself off via
vim.schedule; `with_plugin` queues the enable after that (vim.schedule is
FIFO), so the enable wins.
]]

local M = {}

-- lazy.nvim plugin names, used to check and trigger loading.
local PLUGIN = {
  copilot = "copilot.lua",
  minuet = "minuet-ai.nvim",
}

---@param provider "copilot"|"minuet"
---@return boolean
function M.is_loaded(provider)
  local ok, lazy_config = pcall(require, "lazy.core.config")
  if not ok then
    return false
  end
  local plugin = lazy_config.plugins[PLUGIN[provider]]
  return plugin ~= nil and plugin._.loaded ~= nil
end

---Run `fn` with the provider's plugin loaded. On first load, defer `fn` so it
---runs after the plugin's own scheduled default-off.
---@param provider "copilot"|"minuet"
---@param fn fun()
local function with_plugin(provider, fn)
  if M.is_loaded(provider) then
    fn()
    return
  end
  local ok = pcall(function()
    require("lazy").load({ plugins = { PLUGIN[provider] } })
  end)
  if ok then
    vim.schedule(fn)
  end
end

-- ---------------------------------------------------------------------------
-- State queries
-- ---------------------------------------------------------------------------

function M.is_copilot_enabled()
  if not M.is_loaded("copilot") then
    return false
  end
  local ok, client = pcall(require, "copilot.client")
  if not ok then
    return false
  end
  return not client.is_disabled()
end

function M.is_minuet_enabled()
  if not M.is_loaded("minuet") then
    return false
  end
  local ok, minuet = pcall(require, "minuet")
  if not ok or not minuet.config or not minuet.config.blink then
    return false
  end
  return minuet.config.blink.enable_auto_complete == true
end

-- ---------------------------------------------------------------------------
-- Copilot actions
-- ---------------------------------------------------------------------------

---@param opts? { silent?: boolean }
function M.enable_copilot(opts)
  opts = opts or {}
  with_plugin("copilot", function()
    local ok, cmd = pcall(require, "copilot.command")
    if not ok then
      return
    end
    cmd.enable()
    if not opts.silent then
      vim.notify("Copilot: enabled", vim.log.levels.INFO)
    end
  end)
end

---@param opts? { silent?: boolean }
function M.disable_copilot(opts)
  opts = opts or {}
  if not M.is_loaded("copilot") then
    return -- never loaded means never enabled
  end
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
-- Minuet actions
-- ---------------------------------------------------------------------------

-- Minuet's own :Minuet blink enable/disable/toggle emits "Minuet blink
-- enabled/disabled" — we set the state field directly to bypass that and
-- emit our own "Minuet: ..." for branding consistency.

---@param opts? { silent?: boolean }
function M.enable_minuet(opts)
  opts = opts or {}
  with_plugin("minuet", function()
    local ok, minuet = pcall(require, "minuet")
    if not ok or not minuet.config or not minuet.config.blink then
      return
    end
    minuet.config.blink.enable_auto_complete = true
    if not opts.silent then
      vim.notify("Minuet: enabled", vim.log.levels.INFO)
    end
  end)
end

---@param opts? { silent?: boolean }
function M.disable_minuet(opts)
  opts = opts or {}
  if not M.is_loaded("minuet") then
    return
  end
  local ok, minuet = pcall(require, "minuet")
  if not ok or not minuet.config or not minuet.config.blink then
    return
  end
  minuet.config.blink.enable_auto_complete = false
  if not opts.silent then
    vim.notify("Minuet: disabled", vim.log.levels.INFO)
  end
end

function M.toggle_minuet()
  if M.is_minuet_enabled() then
    M.disable_minuet()
  else
    M.enable_minuet()
  end
end

-- ---------------------------------------------------------------------------
-- Combined
-- ---------------------------------------------------------------------------

-- Master toggle: if any provider is on → disable all. If all off → enable
-- all. One combined notification instead of one per provider.
function M.toggle_all()
  local any_on = M.is_copilot_enabled() or M.is_minuet_enabled()
  if any_on then
    M.disable_copilot({ silent = true })
    M.disable_minuet({ silent = true })
    vim.notify("AI: all disabled", vim.log.levels.INFO)
  else
    M.enable_copilot({ silent = true })
    M.enable_minuet({ silent = true })
    vim.notify("AI: all enabled", vim.log.levels.INFO)
  end
end

-- ---------------------------------------------------------------------------
-- Statusline
-- ---------------------------------------------------------------------------

-- Per-provider glyphs, each colored by the same hl group used elsewhere for
-- that provider (see lua/config/plugins/mini-icons.lua). Uses statusline
-- `%#HlGroup#...%*` markup so each icon carries its own color without needing
-- multiple lualine components.
--
-- Glyphs mirror the blink `kind_icons` in completion.lua and the mini-icons
-- `lsp` entries — one source of truth per provider.
local GLYPHS = {
  copilot = { icon = "", name = "Copilot", hl = "MiniIconsGreen" },
  -- nf-fa-microchip; older codepoint than nf-md-brain, works on more fonts.
  minuet = { icon = "", name = "Minuet", hl = "MiniIconsYellow" },
}

function M.statusline()
  local c = M.is_copilot_enabled()
  local m = M.is_minuet_enabled()
  if not c and not m then
    return "%#Comment#AI off%*"
  end
  local parts = { "AI" }
  if c then
    table.insert(parts, string.format("%%#%s#%s %s%%*", GLYPHS.copilot.hl, GLYPHS.copilot.icon, GLYPHS.copilot.name))
  end
  if m then
    table.insert(parts, string.format("%%#%s#%s %s%%*", GLYPHS.minuet.hl, GLYPHS.minuet.icon, GLYPHS.minuet.name))
  end
  return table.concat(parts, " ")
end

return M
