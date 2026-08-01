--[[
Runtime enable/disable of nvim-lint linters without touching
`lint.linters_by_ft`.

nvim-lint's `try_lint()` takes an optional list of linter names to run. We
maintain a session-local set of disabled linters and, in the autocmd
callback, pass only the enabled ones for the current filetype. State is
in-memory only — reset on every nvim restart.

Usage:

  local tl = require("config.utils.toggle_linter")
  tl.toggle("markdownlint")
  tl.enable("shellcheck")
  tl.disable("hadolint")

  -- In the nvim-lint autocmd (see plugins/nvim-lint.lua):
  local linters = require("lint").linters_by_ft[vim.bo.filetype] or {}
  local enabled = tl.filter(linters)
  if #enabled > 0 then
    require("lint").try_lint(enabled)
  end
]]

local M = {}

---Set of currently-disabled linter names. `nil` == enabled.
---@type table<string, boolean>
local disabled = {}

---@param name string
---@return boolean
function M.is_enabled(name)
  return not disabled[name]
end

---@param name string
function M.enable(name)
  disabled[name] = nil
  vim.notify("Linter " .. name .. ": enabled", vim.log.levels.INFO)
end

---@param name string
function M.disable(name)
  disabled[name] = true
  vim.notify("Linter " .. name .. ": disabled", vim.log.levels.INFO)
end

---@param name string
function M.toggle(name)
  if M.is_enabled(name) then
    M.disable(name)
  else
    M.enable(name)
  end
end

---Return only the enabled linters from a given list. Preserves order.
---@param linters string[]
---@return string[]
function M.filter(linters)
  local out = {}
  for _, name in ipairs(linters) do
    if M.is_enabled(name) then
      table.insert(out, name)
    end
  end
  return out
end

return M
