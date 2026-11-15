-- graphql-language-service-cli
-- https://github.com/graphql/graphiql/tree/main/packages/graphql-language-service-cli
-- Install: Mason -> graphql-language-service-cli
-- Settings: https://the-guild.dev/graphql/config/docs
-- :h lsp-config

-- cmd comes from nvim-lspconfig. Overrides:
--   - filetypes: also plain .ts/.js files (gql tags outside React files).
--   - root_dir: only start where a GraphQL config exists. lspconfig's root_dir
--     calls on_dir(nil) without one, which starts a useless single-file
--     server on every TS/JS buffer.

local CONFIG_FILES = {
  ".graphqlrc",
  ".graphqlrc.json",
  ".graphqlrc.yaml",
  ".graphqlrc.yml",
  ".graphqlrc.toml",
  ".graphqlrc.js",
  ".graphqlrc.ts",
  "graphql.config.js",
  "graphql.config.ts",
  "graphql.config.json",
  "graphql.config.yaml",
  "graphql.config.yml",
}

return {
  filetypes = {
    "graphql",
    "typescriptreact",
    "javascriptreact",
    "typescript",
    "javascript",
  },
  root_dir = function(bufnr, on_dir)
    local root = vim.fs.root(bufnr, CONFIG_FILES)
    if root then
      on_dir(root)
    end
  end,
}
