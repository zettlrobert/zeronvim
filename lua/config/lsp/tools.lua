---[[
---Mason-tool-installer targets: formatters, linters, and debug adapters.
---
---These don't fit the lsp/<name>.lua convention (no per-tool config file),
---so they live here as plain lists. mason.lua consumes them.
---]]

local M = {}

M.formatters = {
  prettierd = "prettierd",
  stylua = "stylua",
}

-- Non-LSP linters run via nvim-lint. Filetypes where an LSP already lints
-- (eslint, vale_ls, tflint) are intentionally excluded to avoid double
-- diagnostics.
M.linters = {
  markdownlint = "markdownlint",
  shellcheck = "shellcheck",
  hadolint = "hadolint",
  yamllint = "yamllint",
}

M.debug_adapters = {
  delve = "delve",
  ["js-debug-adapter"] = "js-debug-adapter",
}

return M
