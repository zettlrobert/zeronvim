local M = {}

--[[
Toggle window-local spellchecking. `spell` is window-scoped in Neovim, so
vim.opt_local is the technically-correct vector. `spelllang` is configured
globally in lua/config/options.lua (en_us + de_de) — toggling just flips
visibility, not language.
]]
local toggle_spell = function()
  vim.opt_local.spell = not vim.wo.spell
  local state = vim.wo.spell and "enabled" or "disabled"
  vim.notify(("Spellcheck %s"):format(state), vim.log.levels.INFO, { title = "Spell" })
end

M.toggle_spell = toggle_spell

return M
