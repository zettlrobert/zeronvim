-- https://github.com/stevearc/conform.nvim
-- Replaces the deprecated none-ls (null-ls fork) for formatting.
-- lsp_format = "fallback" uses LSP formatting only for filetypes without a conform
-- formatter, so JS/TS get prettierd and no ESLint fixes on save.

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
      -- First available wins: prettier projects get prettier, everything else
      -- gets markdownlint's fixes (no re-wrapping, no quote rewrites).
      markdown = { "prettierd_project", "markdownlint-cli2", stop_after_first = true },
      mdx = { "prettierd" },
      astro = { "prettierd" },
      svelte = { "prettierd" },
      vue = { "prettierd" },
    },
    -- Skip *.presentation.md files (matches the legacy none-ls behavior)
    format_on_save = function(bufnr)
      if require("config.utils").is_presentation_markdown(bufnr) then
        return
      end
      -- No LSP fallback for markdown and yaml: outside a prettier project yamlls
      -- would reformat with its own prettier defaults instead.
      local filetype = vim.bo[bufnr].filetype
      local lsp_format = (filetype == "markdown" or filetype == "yaml") and "never" or "fallback"
      return { timeout_ms = 1000, lsp_format = lsp_format }
    end,
    formatters = {
      stylua = {
        prepend_args = { "--indent-type=Spaces", "--indent-width=2" },
      },
      -- Markdown and yaml: format only in a prettier project (a .prettierrc*,
      -- prettier.config.*, or a "prettier" key in package.json), with that
      -- project's settings. Elsewhere markdown falls back to markdownlint-cli2
      -- and yaml is left alone, so nothing rewrites quotes or wraps on save.
      prettierd_project = {
        inherit = "prettierd",
        require_cwd = true,
      },
      -- Outside projects with their own markdownlint config, use this repo's
      -- .markdownlint.jsonc, which keeps compact |---| table delimiters.
      ["markdownlint-cli2"] = {
        prepend_args = function(_, ctx)
          local project_config = vim.fs.find({
            ".markdownlint-cli2.jsonc",
            ".markdownlint-cli2.yaml",
            ".markdownlint-cli2.cjs",
            ".markdownlint.jsonc",
            ".markdownlint.json",
            ".markdownlint.yaml",
            ".markdownlint.yml",
            ".markdownlint.cjs",
          }, { path = ctx.dirname, upward = true })[1]
          if project_config then
            return {}
          end
          return { "--config", vim.fn.stdpath("config") .. "/.markdownlint.jsonc" }
        end,
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
