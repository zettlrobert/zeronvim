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
    -- Compute path directly instead of via `mason-registry:get_install_path()`.
    -- Mason 2.x's Package API changed and the method was returning nil on
    -- some machines, causing the whole config to error and never register
    -- `pwa-node` / `pwa-chrome` adapters (dap.adapters was missing them).
    -- The install path is stable — Mason always puts packages under
    -- `<stdpath('data')>/mason/packages/<name>`.
    local js_debug_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter"

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
