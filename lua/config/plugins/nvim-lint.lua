-- https://github.com/mfussenegger/nvim-lint
-- Runs external linters that aren't LSP servers and surfaces their output
-- via vim.diagnostic. Complements conform.nvim (formatting) and the LSP
-- servers configured under lsp/.
--
-- Filetypes with LSP-based linting (eslint, vale_ls, tflint) are intentionally
-- omitted here — no double diagnostics.
--
-- Linter binaries are installed via Mason from lua/config/lsp/tools.lua.

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile", "BufWritePost" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      markdown = { "markdownlint" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
      dockerfile = { "hadolint" },
      yaml = { "yamllint" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
      group = vim.api.nvim_create_augroup("NvimLintTrigger", { clear = true }),
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
