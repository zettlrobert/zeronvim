-- https://github.com/stevearc/conform.nvim
-- Replaces the deprecated none-ls (null-ls fork) for formatting.
-- LSP-based formatting (e.g. eslint --fix) still works via lsp_format = "fallback".

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettierd" },
      javascriptreact = { "prettierd" },
      typescript = { "prettierd" },
      typescriptreact = { "prettierd" },
      json = { "prettierd" },
      jsonc = { "prettierd" },
      yaml = { "prettierd_project" },
      html = { "prettierd" },
      css = { "prettierd" },
      scss = { "prettierd" },
      markdown = { "prettierd_project" },
      mdx = { "prettierd" },
      astro = { "prettierd" },
      svelte = { "prettierd" },
      vue = { "prettierd" },
    },
    -- Skip *.presentation.md files (matches the legacy none-ls behavior)
    format_on_save = function(bufnr)
      if require("config.utils").is_presentation_markdown() then
        return
      end
      -- No LSP fallback for markdown and yaml: outside a prettier project yamlls
      -- would reformat with its own prettier defaults instead.
      local ft = vim.bo[bufnr].filetype
      local lsp_format = (ft == "markdown" or ft == "yaml") and "never" or "fallback"
      return { timeout_ms = 1000, lsp_format = lsp_format }
    end,
    formatters = {
      stylua = {
        prepend_args = { "--indent-type=Spaces", "--indent-width=2" },
      },
      -- Markdown and yaml: format only in a prettier project (a .prettierrc*,
      -- prettier.config.*, or a "prettier" key in package.json), with that
      -- project's settings. Elsewhere the git hooks' markdownlint --fix and
      -- yamllint apply, and nothing rewrites quotes or wraps on save.
      prettierd_project = {
        inherit = "prettierd",
        require_cwd = true,
      },
      prettierd = {
        prepend_args = {
          "--printWidth=80",
          "--single-quote",
          "--trailing-comma=all",
          "--bracket-spacing",
          "--bracket-sameLine",
          "--semi=true",
          "--useTabs=false",
          "--tabWidth=2",
          "--arrowParens=always",
        },
      },
    },
  },
}
