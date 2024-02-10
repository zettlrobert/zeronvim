local notifications = require("assets.notifications")
local Spell = {}

-- Parse the langauge code
local parse_language_code = function(languageCode)
  local trimmed = string.gsub(languageCode, "_.*", "")
  return trimmed
end

-- Update the 
local change_spellfile = function(languageCode)
  vim.o.spellfile = vim.fn.stdpath("config") .. "/spell/" .. (parse_language_code(languageCode)) .. ".utf-8.add"
end

-- Enable Spellcheck with Language
Spell.spellcheck_enable = function(languageCode)
  vim.o.spell = true
  vim.o.spelllang = languageCode or "en_us"
  change_spellfile(languageCode or "en_us")
  vim.notify(notifications.Spell.spell_enabled .. " - " .. notifications.Spell[languageCode or "en_us"])
end

-- Disable Spellcheck
Spell.spellcheck_disable = function()
  if vim.o.spell then
    vim.o.spell = false
    vim.notify(notifications.Spell.spell_disabled)
  end
end

-- Command to disable spellchecking
vim.api.nvim_create_user_command("SpellCheckDisable", Spell.spellcheck_disable, {})

-- Command to toggle spellchecking
vim.api.nvim_create_user_command("SpellCheckEnable", function()
  Spell.spellcheck_enable()
end, {})

-- Command to toggle spellchecking english us
vim.api.nvim_create_user_command("SpellCheckEnglish", function()
  Spell.spellcheck_enable("en_us")
end, {})

-- Command to toggle spellchecking german us
vim.api.nvim_create_user_command("SpellCheckGerman", function()
  Spell.spellcheck_enable("de_de")
end, {})

-- Keymaps
vim.keymap.set("n", "<leader>spell", function()
  Spell.spellcheck_enable()
end, { desc = notifications.ShortcutDescription.spellcheck_enabled })

vim.keymap.set("n", "<leader>spelloff", function()
  Spell.spellcheck_disable()
end, { desc = notifications.ShortcutDescription.spellcheck_disabled })

return {
  spell = Spell,
}
