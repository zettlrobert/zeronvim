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
      yaml = { "prettierd" },
      html = { "prettierd" },
      css = { "prettierd" },
      scss = { "prettierd" },
      markdown = { "prettierd" },
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
      return { timeout_ms = 1000, lsp_format = "fallback" }
    end,
    formatters = {
      stylua = {
        prepend_args = { "--indent-type=Spaces", "--indent-width=2" },
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
