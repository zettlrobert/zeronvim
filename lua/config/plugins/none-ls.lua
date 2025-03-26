-- https://github.com/nvimtools/none-ls.nvim
-- https://github.com/nvimtools/none-ls-extras.nvim

return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    return
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
            null_ls.builtins.formatting["prettierd"].with({
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
            -- null_ls.builtins.diagnostics.vale,
          },
        })
  end
}
