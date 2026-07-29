-- https://github.com/mfussenegger/nvim-dap
--
-- Debug Adapter Protocol client. Ships the core (session lifecycle,
-- breakpoints, stepping, REPL) but no UI and no adapters. The UIs live in
-- nvim-dap-view.lua and nvim-dap-ui.lua; the adapters are registered by
-- mason-nvim-dap.lua (delve, js-debug-adapter) and nvim-dap-vscode-js.lua
-- (pwa-node, pwa-chrome). Per-language launch configs live in lua/config/dap/.

return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  config = function()
    require("config.dap")
  end,
}
