local M = {}

---Toggle window-local spellchecking. `spell` is window-scoped, so
---vim.opt_local is the right setter. `spelllang` is set globally in
---lua/config/options.lua (en_us + de_de); this only flips visibility, not
---the language.
local toggle_spell = function()
  vim.opt_local.spell = not vim.wo.spell
  local state = vim.wo.spell and "enabled" or "disabled"
  vim.notify(("Spellcheck %s"):format(state), vim.log.levels.INFO, { title = "Spell" })
end

M.toggle_spell = toggle_spell

return M
