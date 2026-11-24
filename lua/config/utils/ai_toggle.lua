--[[
Centralized state, actions, and statusline component for the AI providers
(Copilot + Minuet).

Notification format is normalized: "Copilot: enabled/disabled" and
"Minuet: enabled/disabled".

Every plugin call is pcall-guarded so calls from the statusline / keymaps
don't break if a plugin failed to load.

Lazy loading: both plugins are `lazy = true` and only load when a
provider is first enabled. A provider whose plugin is not loaded counts as
off, and the state queries never `require` it, so the statusline does not
pull a plugin in. Each plugin's config still defaults itself off via
vim.schedule; `with_plugin` queues the enable after that (vim.schedule is
FIFO), so the enable wins.
]]

local icons = require("config.assets.icons")

local M = {}

---@alias AiProvider "copilot"|"minuet"

---@class AiProviderSpec
---@field plugin string lazy.nvim plugin name, used to check and trigger loading
---@field name string display name in notifications and the statusline
---@field icon string statusline glyph (shared with blink and mini.icons)
---@field hl string statusline highlight (same group mini.icons uses)
---@field get fun(): boolean current state; only called once the plugin is loaded
---@field set fun(on: boolean) switch the provider; only called once loaded

---Minuet's blink config table, or nil when minuet is not loaded.
---Minuet's own :Minuet blink enable/disable/toggle emits "Minuet blink
---enabled/disabled", so its state field is set directly to keep the
---"Minuet: ..." notification format.
---@return table|nil
local function minuet_blink()
  local ok, minuet = pcall(require, "minuet")
  return ok and minuet.config and minuet.config.blink or nil
end

---@type table<AiProvider, AiProviderSpec>
local PROVIDERS = {
  copilot = {
    plugin = "copilot.lua",
    name = "Copilot",
    icon = icons.AI.Copilot,
    hl = "MiniIconsGreen",
    get = function()
      local ok, client = pcall(require, "copilot.client")
      return ok and not client.is_disabled()
    end,
    set = function(on)
      local ok, cmd = pcall(require, "copilot.command")
      if ok then
        pcall(on and cmd.enable or cmd.disable)
      end
    end,
  },
  minuet = {
    plugin = "minuet-ai.nvim",
    name = "Minuet",
    icon = icons.AI.Minuet,
    hl = "MiniIconsYellow",
    get = function()
      local blink = minuet_blink()
      return blink ~= nil and blink.enable_auto_complete == true
    end,
    set = function(on)
      local blink = minuet_blink()
      if blink then
        blink.enable_auto_complete = on
      end
      if on then
        local o = require("minuet").config.provider_options.openai_fim_compatible
        require("config.utils.ollama_warm").warm(o.end_point, o.model, true)
      end
    end,
  },
}

-- Statusline order
local ORDER = { "copilot", "minuet" }

---Whether lazy.nvim has loaded the provider's plugin.
---@param provider AiProvider
---@return boolean
function M.is_loaded(provider)
  local ok, lazy_config = pcall(require, "lazy.core.config")
  if not ok then
    return false
  end
  local plugin = lazy_config.plugins[PROVIDERS[provider].plugin]
  return plugin ~= nil and plugin._.loaded ~= nil
end

---Run `fn` with the provider's plugin loaded. On first load, defer `fn` so it
---runs after the plugin's own scheduled default-off.
---@param provider AiProvider
---@param callback fun()
local function with_plugin(provider, callback)
  if M.is_loaded(provider) then
    callback()
    return
  end
  local ok = pcall(function()
    require("lazy").load({ plugins = { PROVIDERS[provider].plugin } })
  end)
  if ok then
    vim.schedule(callback)
  end
end

---Redraw lualine so the AI component reflects the new state.
local function refresh_statusline()
  if package.loaded["lualine"] then
    pcall(require("lualine").refresh)
  end
end

---Whether the provider's plugin is loaded and switched on.
---@param provider AiProvider
---@return boolean
function M.is_enabled(provider)
  return M.is_loaded(provider) and PROVIDERS[provider].get()
end

---Switch a provider on or off. Enabling loads its plugin; disabling a provider
---that never loaded is a no-op (never loaded means never enabled).
---@param provider AiProvider
---@param on boolean
---@param opts? { silent?: boolean }
function M.set(provider, on, opts)
  opts = opts or {}
  local spec = PROVIDERS[provider]
  ---Switch the loaded plugin, notify and refresh the statusline.
  local function apply()
    spec.set(on)
    if not opts.silent then
      vim.notify(spec.name .. ": " .. (on and "enabled" or "disabled"), vim.log.levels.INFO)
    end
    refresh_statusline()
  end
  if on then
    with_plugin(provider, apply)
  elseif M.is_loaded(provider) then
    apply()
  end
end

---Flip a provider between on and off.
---@param provider AiProvider
function M.toggle(provider)
  M.set(provider, not M.is_enabled(provider))
end

-- Named wrappers used by keymaps, lualine, completion.lua and plugin configs.

---@return boolean
function M.is_copilot_enabled()
  return M.is_enabled("copilot")
end
---@return boolean
function M.is_minuet_enabled()
  return M.is_enabled("minuet")
end
---@param opts? { silent?: boolean } silent skips the notification
function M.enable_copilot(opts)
  M.set("copilot", true, opts)
end
---@param opts? { silent?: boolean }
function M.disable_copilot(opts)
  M.set("copilot", false, opts)
end
---@param opts? { silent?: boolean }
function M.enable_minuet(opts)
  M.set("minuet", true, opts)
end
---@param opts? { silent?: boolean }
function M.disable_minuet(opts)
  M.set("minuet", false, opts)
end
function M.toggle_copilot()
  M.toggle("copilot")
end
function M.toggle_minuet()
  M.toggle("minuet")
end

---Master toggle: if any provider is on, disable all; if all are off, enable
---all. Sends one combined notification instead of one per provider.
function M.toggle_all()
  local any_on = false
  for _, provider in ipairs(ORDER) do
    any_on = any_on or M.is_enabled(provider)
  end
  for _, provider in ipairs(ORDER) do
    M.set(provider, not any_on, { silent = true })
  end
  vim.notify("AI: all " .. (any_on and "disabled" or "enabled"), vim.log.levels.INFO)
end

---Statusline text: each enabled provider's glyph, colored with its own hl
---group via `%#HlGroup#...%*` markup, so one lualine component carries
---several colors.
---@return string
function M.statusline()
  local parts = {}
  for _, provider in ipairs(ORDER) do
    if M.is_enabled(provider) then
      local spec = PROVIDERS[provider]
      parts[#parts + 1] = string.format("%%#%s#%s %s%%*", spec.hl, spec.icon, spec.name)
    end
  end
  if #parts == 0 then
    return "%#Comment#AI off%*"
  end
  return "AI " .. table.concat(parts, " ")
end

return M
