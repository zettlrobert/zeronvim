-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/folke/lazydev.nvim
return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "saghen/blink.cmp",
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
    config = function()
      local lspconfig = require("lspconfig")
      local server_list = require("config.plugins.lsp.servers").server_list

      vim.keymap.set("n", "<space>d", vim.diagnostic.open_float)

      -- Iterate over all installed servers and setup
      for _, server in pairs(server_list) do
        -- Auto Setup
        lspconfig[server].setup({})

        -- Overwrite for eslint-lsp
        -- https://github.com/hrsh7th/vscode-langservers-extracted
        if server == "eslint" then
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

        if server == "volar" then
          lspconfig["volar"].setup({
            filetypes = { "vue" },
            init_options = {
              vue = {
                hybridMode = false,
              },
              typescript = {
                tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
              },
            },
          })
        end
      end
    end,
  },
}
