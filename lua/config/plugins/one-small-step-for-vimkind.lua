-- https://github.com/jbyuki/one-small-step-for-vimkind
--
-- Lua debug adapter for Neovim itself. Runs a debug server INSIDE the nvim
-- instance you want to debug (via `Snacks`/plugin/config code); a SECOND
-- nvim instance then attaches to that server via nvim-dap.
--
-- Launch/attach configs live in lua/config/dap/lua.lua. Standalone Lua
-- (outside nvim) is a different tool (`local-lua-debugger-vscode`) — not
-- set up here.

return {
  "jbyuki/one-small-step-for-vimkind",
  dependencies = { "mfussenegger/nvim-dap" },
  event = "VeryLazy",
}
