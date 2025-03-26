--[[
@link ttps://github.com/olimorris/codecompanion.nvim

`:CodeCompanionChat` - open a chat buffer which opens on a single response per turn basis
  - <C-s> send prompt
  - <CR> send prompt

`:CodeCompanionChat Toggle` open the chat buffer and send a prompt at the same time

Code context can be added via Variables and `Slash Commands` in the chat buffer
  - #buffer - Shares the current buffer's code. This can also receive parameters
  - #lsp - Shares LSP information and code for the current buffer
  - #viewport - Shares the buffers and lines that you see in the Neovim viewport

--]]
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter"
  },
  config = function()
    local codecompanion = require("codecompanion")
    local cc_adapters = require("codecompanion.adapters")

    codecompanion.setup({
      --https://github.com/olimorris/codecompanion.nvim
      strategies = {
        chat = {
          adapter = "deepseek-r1:32b"
        },
        inline = {
          adapter = "deepseek-r1:32b"
        }
      },

      --https://codecompanion.olimorris.dev/configuration/adapters.html
      adapters = {
        ["deepseek-r1:32b"] = function()
          return cc_adapters.extend("ollama", {
            name = "deepseek-r1:32b",
            schema = {
              model = {
                default = "deepseek-r1:32b",
              },
              num_ctx = {
                default = 16384
              },
              num_predict = {
                default = -1
              }
            }
          })
        end,
      },

      --https://github.com/olimorris/codecompanion.nvim
      sources = {
        per_file = {
          codecompanion = { "codecompanion" }
        }
      }
    })
  end
}
