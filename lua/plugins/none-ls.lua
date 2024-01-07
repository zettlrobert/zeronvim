-- https://github.com/nvimtools/none-ls.nvim
return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require('null-ls')

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting['prettier'].with({
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
              "--arrowParens=always"
            }
          end
        })
      },
      null_ls.builtins.diagnostics.eslint_d
    })

    vim.keymap.set('n', '<space>f', vim.lsp.buf.format)
  end
}
