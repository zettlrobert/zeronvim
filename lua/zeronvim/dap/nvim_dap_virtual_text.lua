local utils = require "zeronvim.utils"
local nvim_dap_virtual_text = utils.protected_plugin_call("nvim-dap-virtual-text")
local M = {}

if nvim_dap_virtual_text then
  M.setup = function()
    vim.notify("nvim_dap_virtual_text module, loaded")
    nvim_dap_virtual_text.setup()
  end
end

return M
