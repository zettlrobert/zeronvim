local M = {}

-- List of servers that will be auto installed via mason
-- The key is the mason name the value the language server identifier
M.server_list = {
  ["bashls"] = "bashls",
  ["clangd"] = "clangd",
  ["cmake"] = "cmake",
  ["cssls"] = "cssls",
  ["cssmodules_ls"] = "cssmodules_ls",
  ["docker_compose_language_service"] = "docker_compose_language_service",
  ["dockerls"] = "dockerls",
  ["eslint"] = "eslint",
  ["gopls"] = "gopls",
  ["graphql"] = "graphql",
  ["html"] = "html",
  -- ["htmx"] = "htmx", -- This is breaking typescript-tools
  ["lua_ls"] = "lua_ls",
  ["marksman"] = "marksman",
  ["mdx_analyzer"] = "mdx_analyzer",
  ["prismals"] = "prismals",
  ["pyright"] = "pyright",
  ["rust_analyzer"] = "rust_analyzer",
  ["sqls"] = "sqls",
  ["svelte"] = "svelte",
  ["tailwindcss"] = "tailwindcss",
  ["taplo"] = "taplo",
  ["terraformls"] = "terraformls",
  ["tflint"] = "tflint",
  ["volar"] = "volar",
  ["yamlls"] = "yamlls",
}

-- TODO DAP
local daps = {
  ["delve"] = "delve",
}

-- TODO Formatters
local formatters = {
  ["prettierd"] = "prettierd",
  ["stylua"] = "luau",
}

return M
