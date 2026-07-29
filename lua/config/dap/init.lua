--[[
Shared DAP setup:
  - Custom sign icons for the gutter (breakpoint, condition, log, stopped)
  - Event listeners (currently none — placeholders for future auto-open UIs)
  - Requires per-language launch configs (typescript, go)

Per-language configs live alongside this file (config.dap.typescript,
config.dap.go) so adding a new language is `require("config.dap.<lang>")`
plus (optionally) a Mason adapter and mason-nvim-dap mapping.
]]

local dap = require("dap")

-- Gutter signs for breakpoints and current line
local signs = {
  DapBreakpoint = { text = "●", texthl = "DiagnosticSignError" },
  DapBreakpointCondition = { text = "◆", texthl = "DiagnosticSignWarn" },
  DapLogPoint = { text = "◉", texthl = "DiagnosticSignInfo" },
  DapStopped = { text = "▶", texthl = "DiagnosticSignHint", linehl = "Visual" },
  DapBreakpointRejected = { text = "○", texthl = "DiagnosticSignError" },
}
for name, opts in pairs(signs) do
  vim.fn.sign_define(name, opts)
end

-- Language-specific launch configs
require("config.dap.typescript")
require("config.dap.go")

return dap
