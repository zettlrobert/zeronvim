local utils = require "zeronvim.utils"
local nvim_navic = utils.protected_plugin_call("nvim-navic")

if nvim_navic then
  nvim_navic.setup({
    highlight = true,
    separator = " " .. ">" .. " "
  })
end
