local M = {}
-- Custom Function to toggle spell check
M.toggle_spell_check = function()
  if (vim.o.spell) then
    vim.o.spell = false
    vim.notify('Spellchecking disabled')
    return
  end

  if (not vim.o.spell) then
    vim.o.spell = true
    vim.notify('Spellchecking enabled')
    return
  end
end

M.add_to_dictionary = function()
  local word_under_cursor = vim.fn.expand('<cword>')
  local command = "spellgood  " .. word_under_cursor
  vim.api.nvim_command(command)
  vim.notify("Added " .. word_under_cursor .. " to dictionary")
end

return M
