--[[
Lua debug configuration for debugging Neovim's own Lua code (config, plugins,
utils) via one-small-step-for-vimkind (osv).

How it works:

1. In the nvim instance you want to inspect (call it "server"), run
   `:lua require("osv").launch({ port = 8086 })`. osv opens a TCP server
   on port 8086 speaking DAP.
2. In ANOTHER nvim instance (call it "client"), open the Lua file you want
   to debug, set a breakpoint, and run `<leader>bc` → "Attach to nvim (osv)".
   The client attaches to the server over :8086.
3. When code runs in the server that hits your breakpoint, execution pauses.
   You inspect / step from the client.
4. `<leader>bx` in the client detaches.

You can also use `:lua require("osv").run_this()` in the server to run
the current buffer's Lua under debug immediately (useful for scripts).
]]

local dap = require("dap")

-- Adapter: connect over TCP to the osv server. `type = "server"` tells
-- nvim-dap to open a socket connection instead of spawning an executable.
dap.adapters.nlua = function(callback, config)
  callback({
    type = "server",
    host = config.host or "127.0.0.1",
    port = config.port or 8086,
  })
end

dap.configurations.lua = {
  {
    type = "nlua",
    request = "attach",
    name = "Attach to nvim (osv)",
    host = "127.0.0.1",
    port = 8086,
  },
}
