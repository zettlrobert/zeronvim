-- vale-ls (Vale language server — prose linting)
-- https://github.com/errata-ai/vale-ls
-- Settings: https://vale.sh/docs/topics/config
-- Install: Mason -> vale-ls (auto-installed via lua/config/plugins/mason.lua)

return {
  cmd = { "vale-ls" },
  filetypes = { "markdown", "text", "tex", "rst", "mdx" },
  root_markers = { ".vale.ini", "_vale.ini", ".git" },
}
