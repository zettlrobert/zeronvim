local utils = require "zeronvim.utils"
local nvim_dap = utils.protected_plugin_call("dap")
local M = {}

if nvim_dap then
  M.setup = function()
    nvim_dap.adapters.node2 = {
      type = 'executable',
      command = 'node',
      args = { os.getenv('HOME') .. '.local/share/nvim/mason/bin/js-debug-adapter' },
    }
    nvim_dap.configurations.javascript = {
      {
        name = 'Launch',
        type = 'node2',
        request = 'launch',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
      },
      {
        -- For this to work you need to make sure the node process is started with the `--inspect` flag.
        name = 'Attach to process',
        type = 'node2',
        request = 'attach',
        processId = require 'dap.utils'.pick_process,
      },
    }
  end
end

return M
