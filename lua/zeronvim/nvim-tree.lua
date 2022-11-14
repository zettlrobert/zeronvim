local utils = require "zeronvim.utils"
local nvim_tree = utils.protected_plugin_call("nvim-tree")

-- ----------------------------------------------------------------------------------------------------------------------
-- disable netrw at the very start of your init.lua (strongly advised)
--[[ vim.g.loaded_netrw = 1 ]]
--[[ vim.g.loaded_netrwPlugin = 1 ]]

-- set termguicolors to enable highlight groups
--[[ vim.opt.termguicolors = true ]]

-- OR setup with some options
if nvim_tree then nvim_tree.setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
end
