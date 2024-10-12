-- https://github.com/nvimtools/none-ls.nvim
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim"
  },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting["stylua"].with({
          extra_args = function()
            return {
              "--indent-type=Spaces",
              "--indent-width=2",
            }
          end,
        }),
        null_ls.builtins.formatting["prettier"].with({
          extra_args = function()
            return {
              "--printWidth=80",
              "--single-quote",
              "--trailing-comma=all",
              "--bracket-spacing=true",
              "--bracket-sameLine=false",
              "--semi",
              "--useTabs=false",
              "--tabWidth=2",
              "--arrowParens=always",
            }
          end,
        }),

        -- Vale
        null_ls.builtins.diagnostics.vale,

        -- require("none-ls.diagnostics.eslint_d")

        -- eslint_d
        -- null_ls.builtins.diagnostics["eslint"].with({
        --   name = "eslint_d",
        --   meta = {
        --     url = "https://github.com/mantoni/eslint_d.js/",
        --     description = "Like ESLint, but faster.",
        --     notes = {
        --       "Once spawned, the server will continue to run in the background. This is normal and not related to null-ls. You can stop it by running `eslint_d stop` from the command line.",
        --     },
        --   },
        --   command = "eslint_d",
        -- }),
      },
    })

    vim.keymap.set("n", "<space>f", vim.lsp.buf.format, { desc = "Format" })
  end,
}
