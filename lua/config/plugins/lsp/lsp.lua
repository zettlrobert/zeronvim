-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/folke/lazydev.nvim
return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    init = function()
      local lspconfig = require("lspconfig")
      local server_list = require("config.plugins.lsp.servers").server_list

      -- Iterate over all installed servers and setup
      for _, server in pairs(server_list) do
        if server == "eslint" then
          -- Overwrite for eslint-lsp
          -- https://github.com/hrsh7th/vscode-langservers-extracted
          lspconfig["eslint"].setup({
            auto_attach = true,
            filetypes = {
              "javascript",
              "javascriptreact",
              "javascript.jsx",
              "typescript",
              "typescriptreact",
              "typescript.tsx",
              "svelte",
              "astro",
            },
            root_dir = lspconfig.util.root_pattern(".git", "tsconfig.base.json", ".eslintrc.json"),
            workingDirectory = {
              mode = "auto",
            },
            settings = {
              useFlatConfig = false, -- set if using flat config
            },
          })
        end

        -- Auto Setup
        lspconfig[server].setup({})
      end
    end,
  },
}
