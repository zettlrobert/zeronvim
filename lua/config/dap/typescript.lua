--[[
TypeScript / JavaScript / Node launch configs (fallback when no
.vscode/launch.json exists in the project — dap-vscode-js reads that file
first when present).

Adapters (pwa-node, pwa-chrome) are registered by nvim-dap-vscode-js.lua.
This file only defines the LAUNCH CONFIGURATIONS.

Applies to filetypes: typescript, typescriptreact, javascript, javascriptreact.
]]

local dap = require("dap")

local js_based_filetypes = {
  "typescript",
  "typescriptreact",
  "javascript",
  "javascriptreact",
}

for _, ft in ipairs(js_based_filetypes) do
  dap.configurations[ft] = {
    -- Launch current file with tsx
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch current file (tsx)",
      cwd = vim.fn.getcwd(),
      runtimeArgs = { "--loader=tsx" },
      runtimeExecutable = "node",
      args = { "${file}" },
      sourceMaps = true,
      protocol = "inspector",
      skipFiles = { "<node_internals>/**", "node_modules/**" },
      resolveSourceMapLocations = {
        "${workspaceFolder}/**",
        "!**/node_modules/**",
      },
    },
    -- Launch current file with ts-node
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch current file (ts-node)",
      cwd = vim.fn.getcwd(),
      runtimeArgs = { "--loader=ts-node/esm" },
      runtimeExecutable = "node",
      args = { "${file}" },
      sourceMaps = true,
      protocol = "inspector",
      skipFiles = { "<node_internals>/**", "node_modules/**" },
    },
    -- Launch plain Node (no TS loader)
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch current file (node)",
      cwd = vim.fn.getcwd(),
      program = "${file}",
      sourceMaps = true,
      protocol = "inspector",
    },
    -- Attach to a running Node process started with `node --inspect` or
    -- `node --inspect-brk`. Useful for long-running servers.
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach to Node process",
      processId = require("dap.utils").pick_process,
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      resolveSourceMapLocations = {
        "${workspaceFolder}/**",
        "!**/node_modules/**",
      },
    },
    -- Debug Vitest tests for the current file
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Vitest current file",
      cwd = vim.fn.getcwd(),
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/vitest/vitest.mjs",
        "run",
        "${file}",
      },
      rootPath = "${workspaceFolder}",
      autoAttachChildProcesses = true,
      smartStep = true,
      console = "integratedTerminal",
      skipFiles = { "<node_internals>/**", "node_modules/**" },
    },
    -- Debug in Chrome (frontend)
    {
      type = "pwa-chrome",
      request = "launch",
      name = "Launch Chrome against localhost",
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
      sourceMaps = true,
      userDataDir = false,
    },
  }
end
