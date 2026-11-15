-- https://github.com/mfussenegger/nvim-dap
--
-- Debug Adapter Protocol client. Ships the core (session lifecycle,
-- breakpoints, stepping, REPL) but no UI and no adapters. The UIs live in
-- nvim-dap-view.lua and nvim-dap-ui.lua; mason-nvim-dap.lua registers the
-- Mason adapters it knows (delve, debugpy, bash), and lua/config/dap/
-- typescript.lua registers js-debug-adapter's pwa-* types. Per-language launch
-- configs live in lua/config/dap/.

return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  config = function()
    require("config.dap")
  end,
}
