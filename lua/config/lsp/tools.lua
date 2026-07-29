---[[
---Mason-tool-installer targets: formatters and debug adapters.
---
---These don't fit the lsp/<name>.lua convention (no per-tool config file),
---so they live here as plain lists. mason.lua consumes them.
---]]

local M = {}

M.formatters = {
  prettierd = "prettierd",
  stylua = "stylua",
}

M.debug_adapters = {
  delve = "delve",
  ["js-debug-adapter"] = "js-debug-adapter",
}

return M
