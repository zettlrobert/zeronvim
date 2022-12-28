local utils = require "zeronvim.utils"
local nvim_dap_ui = utils.protected_plugin_call("dapui")

local M = {}

if nvim_dap_ui then
  M.setup = function()
    nvim_dap_ui.setup()
  end
end

return M
