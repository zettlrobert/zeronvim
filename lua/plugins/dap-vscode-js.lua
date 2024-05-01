return {
  {
    -- Download and install the adapter protocol
    "microsoft/vscode-js-debug",
    build = {
      "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
      -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#javascript
      -- The new setup requires the dapDebugServer, replacing the vsDebugServerBundle
      "npx gulp dapDebugServer",
    },
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      local dap_vs_codejs = require("dap-vscode-js")
      local dap = require("dap")
      local utils = require("utils")
      local nvim_data = vim.fn.stdpath("data")

      -- Use nvm node
      local node_path = utils.get_system_binary("node")

      -- Path to vscode-js-debug
      local debugger_path = nvim_data .. "/lazy/vscode-js-debug"

      -- Adapters to Register with dap_vs_codejs
      local adapters = {
        "pwa-node",
        "pwa-chrome",
        "chrome",
        "pwa-msedge",
        "node-terminal",
        "pwa-extensionHost",
      }

      dap_vs_codejs.setup({
        node_path = "node",
        debugger_path = debugger_path,
        adapaters = adapters,
        log_console_level = vim.log.levels.DEBUG,
      })

      local js_based_filetypes = {
        "typescript",
        "javascript",
        "typescriptreact",
        "javascriptreact",
        "vue",
      }

      for _, js_filetype in ipairs(js_based_filetypes) do
        dap.configurations[js_filetype] = {
          {
            -- Debug single nodejs files
            type = "pwa-node",
            request = "launch",
            name = "Node File (pwa-node)",
            program = "${file}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
          },

          -- Debug single Vitest
          {
            type = "pwa-node",
            request = "launch",
            name = "Vitest File (pwa-node)",
            autoAttachChildProcesses = true,
            runtimeExecutable = "node",
            runtimeArgs = {
              "${workspaceFolder}/node_modules/vitest/vitest.mjs",
              "--inspect-brk",
              "${file}",
              "--poolOptions.threads.singleThread",
              "true",
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            skipFiles = { "<node_internals>/**", "**/node_modules/**" },
          },

          -- Debug nodejs processes (make sure to add --inspect when you run the process)
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to Node Process - Debugger must listen on process",
            processId = require("dap.utils").pick_process,
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
          },

          -- Debug web applications (client side)
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch & Debug Chrome",
            program = "${file}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            url = function()
              local co = coroutine.running()
              return coroutine.create(function()
                vim.ui.input({
                  prompt = "Enter URL: ",
                  default = "http://localhost:3000",
                }, function(url)
                  if url == nil or url == "" then
                    return
                  else
                    coroutine.resume(co, url)
                  end
                end)
              end)
            end,
            webRoot = "${workspaceFolder}",
          },

          -- Divider for the launch.json derived configurations
          {
            name = "----- ↓ launch.json configs ↓ -----",
            type = "",
            request = "launch",
          },
        }
      end

      --
      --
      -- Manual Setup
      -- local dapDebugServer = nvim_data .. "/lazy/vscode-js-debug/dist/src/dapDebugServer.js"
      --
      -- dap.adapters["pwa-node"] = {
      --   type = "server",
      --   host = "localhost",
      --   port = "${port}",
      --   executable = {
      --     command = "node",
      --     args = { dapDebugServer, "${port}" },
      --   },
      -- }
      --
      -- dap.configurations.typescript = {
      --
      --   -- Working
      --   {
      --     type = "pwa-node",
      --     request = "launch",
      --     name = "Vitest Debug (Breakpoints not Respected)",
      --     autoAttachChildProcesses = true,
      --     runtimeExecutable = "node",
      --     runtimeArgs = {
      --       "${workspaceFolder}/node_modules/vitest/vitest.mjs",
      --       "--inspect-brk",
      --       "${file}",
      --       "--poolOptions.threads.singleThread",
      --       "true",
      --     },
      --     rootPath = "${workspaceFolder}",
      --     cwd = "${workspaceFolder}",
      --     console = "integratedTerminal",
      --     skipFiles = { "<node_internals>/**", "**/node_modules/**" },
      --   },
      -- }

      --
      --
      --
    end,
  },
}
