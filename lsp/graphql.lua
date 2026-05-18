-- graphql-language-service-cli
-- https://github.com/graphql/graphiql/tree/main/packages/graphql-language-service-cli
-- Install: Mason -> graphql-language-service-cli
-- Settings: https://the-guild.dev/graphql/config/docs
-- :h lsp-config

return {
  cmd = { "graphql-lsp", "server", "-m", "stream" },
  filetypes = {
    "graphql",
    "typescriptreact",
    "javascriptreact",
    "typescript",
    "javascript",
  },
  -- Needs a .graphqlrc / graphql config to actually do anything useful;
  -- nx monorepos typically keep schemas + config at the workspace root
  root_markers = {
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
    "nx.json",
    "package.json",
    ".git",
  },
}
