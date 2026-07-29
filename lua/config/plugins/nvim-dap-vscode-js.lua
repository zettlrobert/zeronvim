-- https://github.com/mxsdev/nvim-dap-vscode-js
--
-- Bridges vscode-js-debug (installed by Mason as `js-debug-adapter`) into
-- nvim-dap. Registers the pwa-node and pwa-chrome adapters used by our
-- lua/config/dap/typescript.lua launch configs.
--
-- If a project has .vscode/launch.json, this plugin reads it automatically
-- and merges with our Lua fallback configs.

return {
  "mxsdev/nvim-dap-vscode-js",
  dependencies = { "mfussenegger/nvim-dap" },
  event = "VeryLazy",
  config = function()
    local mason_registry = require("mason-registry")
    local js_debug_path = mason_registry.get_package("js-debug-adapter"):get_install_path()

    require("dap-vscode-js").setup({
      debugger_path = js_debug_path,
      debugger_cmd = { "js-debug-adapter" },
      adapters = {
        "pwa-node",
        "pwa-chrome",
        "pwa-msedge",
        "node-terminal",
        "pwa-extensionHost",
      },
    })
  end,
}
