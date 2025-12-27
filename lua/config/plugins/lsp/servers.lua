local M = {}

-- List of servers that will be auto installed via mason
-- The key is the mason name the value the language server identifier
M.language_servers = {
  ["vtsls"] = "vtsls",
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
  --  ["terraformls"] = "terraformls",
  -- ["tofu_ls"] = "tofu_ls",
  ["tflint"] = "tflint",
  -- TODO: Fix vue
  -- ["vuels"] = "vuels",
  ["yamlls"] = "yamlls",
}

-- List of debug adapters that will be auto installed via mason-tool-installer
M.debug_adapters = {
  ["delve"] = "delve",
}

-- List of formatters that will be auto installed via mason-tool-installer
M.formatters = {
  ["prettierd"] = "prettierd",
  ["stylua"] = "stylua",
}

return M
