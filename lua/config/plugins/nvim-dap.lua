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
  -- Loaded on demand: the <leader>b*/<leader>td* keymaps in config/keymaps.lua
  -- require("dap") (or an add-on), which lazy.nvim turns into a load.
  lazy = true,
  config = function()
    require("config.dap")
    -- Add-ons load after our adapters and configurations exist, the same
    -- order as when everything loaded on VeryLazy. mason-nvim-dap appends
    -- its configurations to ours, so it must come after config.dap.
    require("lazy").load({
      plugins = {
        "mason-nvim-dap.nvim",
        "nvim-dap-ui",
        "nvim-dap-view",
        "nvim-dap-virtual-text",
        "one-small-step-for-vimkind",
      },
    })
  end,
}
