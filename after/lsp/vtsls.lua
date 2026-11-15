-- vtsls (TypeScript / JavaScript LSP wrapping tsserver)
-- https://github.com/yioneko/vtsls
-- Settings: https://github.com/yioneko/vtsls/blob/main/packages/service/configuration.schema.json
-- Vue setup: https://github.com/vuejs/language-tools/wiki/Neovim
-- Install: Mason -> vtsls (auto-installed via lua/config/plugins/mason.lua)
-- :h lsp-config
--
-- Only runs in Vue workspaces (see lua/config/lsp/vue.lua); everywhere else
-- after/lsp/tsc.lua (TypeScript 7) is the TypeScript server. Here vtsls loads
-- @vue/typescript-plugin from Mason's vue-language-server and serves the
-- TypeScript parts of .vue files for vue_ls (hybrid mode).
-- cmd comes from nvim-lspconfig.

local vue = require("config.lsp.vue")

-- lspconfig's vtsls root: the nearest package-manager lockfile, else .git.
local ROOT_MARKERS = {
  { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" },
  { ".git" },
}

return {
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
  root_dir = function(bufnr, on_dir)
    if not vue.is_vue_workspace(bufnr) then
      return -- tsc handles non-Vue workspaces
    end
    on_dir(vim.fs.root(bufnr, ROOT_MARKERS) or vim.fn.getcwd())
  end,
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = "@vue/typescript-plugin",
            location = vue.typescript_plugin_location(),
            languages = { "vue" },
            configNamespace = "typescript",
          },
        },
      },
    },
  },
}
