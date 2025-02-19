local M = {}

-- This list represents the available spellcheck languages
local LanguageCode = {
  ["English"] = "en_us",
  ["German"] = "de_de",
}

-- Notifications for `:Spellcheck` commands
local notifications = {
  spell = {
    spell_enabled = "Spellchecking enabled",
    spell_disabled = "Spellchecking disabled",
    already_disabled = "Spellchecking already disabled",
    ["de_de"] = "German",
    ["en_us"] = "English",
    spellfile = "Switched Spellfile to",
  },
}

---Returns the language code without the variant
---@param languageCode any
---@return string
local parse_language_code = function(languageCode)
  local trimmed = string.gsub(languageCode, "_.*", "")
  return trimmed
end

-- Update the

---Updates the spellfile for the language code
---@param languageCode string
local change_spellfile = function(languageCode)
  vim.o.spellfile = vim.fn.stdpath("config") .. "/spell/" .. (parse_language_code(languageCode)) .. ".utf-8.add"
end

---Enables spellchecking for the language code
---@param languageCode string
local spellcheck_enable = function(languageCode)
  vim.o.spell = true
  vim.o.spelllang = languageCode or "en"
  change_spellfile(languageCode or "en")
  vim.notify(notifications.spell.spell_enabled .. " - " .. notifications.spell[languageCode or "en_us"])
end

---Disables spellchecking
local spellcheck_disable = function()
  if vim.o.spell then
    vim.o.spell = false
    vim.notify(notifications.spell.spell_disabled)

    return
  end

  vim.notify(notifications.spell.already_disabled)
end

---Creates a command for spellchecking
---@param opts vim.api.keyset.create_user_command.command_args
vim.api.nvim_create_user_command("Spellcheck", function(opts)
  local arg = opts.args

  if arg == "Disable" then
    spellcheck_disable()

    return
  end

  spellcheck_enable(LanguageCode[arg])
end, {
  nargs = 1,
  complete = function()
    local commands = { "Disable" }

    for key, _ in pairs(LanguageCode) do
      vim.list_extend(commands, { key })
    end

    return commands
  end,
})
