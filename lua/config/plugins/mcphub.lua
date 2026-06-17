--[[
@link https://github.com/ravitemer/mcphub.nvim
@link https://ravitemer.github.io/mcphub.nvim/extensions/codecompanion.html

MCP Hub — wraps MCP (Model Context Protocol) servers and surfaces them as
tools to LLM clients. Wired into CodeCompanion in plugins/codecompanion.lua
via the mcphub extension, so MCP tools appear as @{server__tool} inside
CodeCompanion chats.

Runtime: requires the mcp-hub npm package (installed by the `build` step).

Server configs: ~/.config/mcphub/servers.json — manage via the :MCPHub UI
or hand-edit. Start with no servers; add as you need them.

Useful commands:
  :MCPHub          open the management UI (browse servers + tools)
  :MCPHubAdd       add a new MCP server interactively
]]
return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = "MCPHub",
  build = "npm install -g mcp-hub@latest",
  config = function()
    require("mcphub").setup({})
  end,
}
