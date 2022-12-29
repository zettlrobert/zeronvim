local utils = require "zeronvim.utils"
local nvim_dap = utils.protected_plugin_call("dap")
local M = {}

-- Configuration
local home_directory = os.getenv("HOME")
local mason_chrome_debug = "/.local/share/nvim/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js"
local path_to_chrome_debug_adapter = home_directory .. mason_chrome_debug

if nvim_dap then
  M.setup = function()
    vim.notify("chrome debug adapter setup")
    nvim_dap.adapters.chrome = {
      type = "executable",
      command = "node",
      args = { path_to_chrome_debug_adapter }
    }

    nvim_dap.configurations.javascriptreact = { -- change this to javascript if needed
      {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}"
      }
    }

    nvim_dap.configurations.typescriptreact = { -- change to typescript if needed
      {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}"
      }
    }
  end
end

return M
