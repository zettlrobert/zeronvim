local utils = require "zeronvim.utils"
local nvim_dap = utils.protected_plugin_call("dap")
local M = {}

-- Configuration
local home_directory = os.getenv("HOME")
local mason_firefox_debug = "/.local/share/nvim/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js"
local path_to_firefox_debug_adapter = home_directory .. mason_firefox_debug

if nvim_dap then
  M.setup = function()
    nvim_dap.adapters.firefox = {
      type = 'executable',
      command = 'node',
      args = { path_to_firefox_debug_adapter },
    }

    nvim_dap.configurations.typescriptreact = {
      {
        name = 'Debug with Firefox',
        type = 'firefox',
        request = 'launch',
        reAttach = true,
        url = 'http://localhost:3000',
        webRoot = '${workspaceFolder}',
        firefoxExecutable = '/usr/bin/firefox'
      }
    }
  end
end

return M
