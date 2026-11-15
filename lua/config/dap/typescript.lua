--[[
TypeScript / JavaScript / Node debugging with vscode-js-debug.

Adapters: registered here for Mason's `js-debug-adapter`, which is
vscode-js-debug's DAP server (dapDebugServer.js <port>). nvim-dap starts it
on a free port per session. This replaced mxsdev/nvim-dap-vscode-js, which
did the same and is unmaintained since 2023.

Launch configs: a project's .vscode/launch.json is read by nvim-dap itself
(the "dap.launch.json" config provider). The configs below are the fallback
for projects without one.

Applies to filetypes: typescript, typescriptreact, javascript, javascriptreact.
]]

local dap = require("dap")

-- Adapter types vscode-js-debug implements. Each session gets its own server.
for _, adapter in ipairs({ "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }) do
  dap.adapters[adapter] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = "js-debug-adapter",
      args = { "${port}" },
    },
  }
end

-- VS Code launch.json files often use the legacy "node"/"chrome"/"msedge"
-- types, which js-debug only knows as pwa-*. Map them on the fly.
for _, legacy in ipairs({ "node", "chrome", "msedge" }) do
  dap.adapters[legacy] = function(callback, config)
    config.type = "pwa-" .. legacy
    callback(dap.adapters[config.type])
  end
end

local js_based_filetypes = {
  "typescript",
  "typescriptreact",
  "javascript",
  "javascriptreact",
}

for _, filetype in ipairs(js_based_filetypes) do
  dap.configurations[filetype] = {
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
