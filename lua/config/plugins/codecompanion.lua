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
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local codecompanion = require("codecompanion")
    local cc_adapters = require("codecompanion.adapters")

    codecompanion.setup({
      --https://github.com/olimorris/codecompanion.nvim
      strategies = {
        chat = {
          adapter = "gpt-oss",
          completion_provider = "cmp",
          tools = {
            opts = {
              auto_submit_errors = true,
              auto_submit_success = true,
            },
          },
        },
        inline = {
          adapter = "gpt-oss",
        },
        cmd = {
          adapter = "gpt-oss",
        },
      },

      --https://codecompanion.olimorris.dev/configuration/adapters.html
      adapters = {
        http = {
          --https://ollama.com/library/gpt-oss
          ["gpt-oss"] = function()
            return cc_adapters.extend("ollama", {
              name = "gpt-oss",
              schema = {
                model = {
                  default = "gpt-oss",
                },
                num_ctx = {
                  default = 16384,
                },
                num_predict = {
                  default = -1,
                },
              },
            })
          end,
          ["devstral"] = function()
            return cc_adapters.extend("ollama", {
              name = "devstral",
              schema = {
                model = {
                  default = "devstral",
                },
                num_ctx = {
                  default = 16384,
                },
                num_predict = {
                  default = -1,
                },
              },
            })
          end,
          ["deepseek-r1:32b"] = function()
            return cc_adapters.extend("ollama", {
              name = "deepseek-r1:32b",
              schema = {
                model = {
                  default = "deepseek-r1:32b",
                },
                num_ctx = {
                  default = 16384,
                },
                num_predict = {
                  default = -1,
                },
              },
            })
          end,
          ---https://huggingface.co/Qwen/Qwen2.5-Coder-32B/blob/main/README.md
          ["qwen2.5-coder:32b"] = function()
            return cc_adapters.extend("ollama", {
              name = "qwen2.5-coder:32b",
              schema = {
                model = {
                  default = "qwen2.5-coder:32b",
                },
                num_ctx = {
                  default = 16384,
                },
                num_predict = {
                  default = -1,
                },
              },
            })
          end,
          ---https://ollama.com/library/deepseek-coder-v2
          ["deepseek-coder-v2:latest"] = function()
            return cc_adapters.extend("ollama", {
              name = "deepseek-coder-v2:latest",
              schema = {
                model = {
                  default = "deepseek-coder-v2:latest",
                },
                num_ctx = {
                  default = 16384,
                },
                num_predict = {
                  default = -1,
                },
              },
            })
          end,
          ["qwen3:32b"] = function()
            return cc_adapters("ollama", {
              name = "qwen3:32b",
              schema = {
                model = {
                  default = "qwen3:32b",
                },
                num_ctx = {
                  default = 16384,
                },
                num_predict = {
                  default = -1,
                },
              },
            })
          end,
          ---https://ollama.com/library/gemma3
          ["gemma3:12b"] = function()
            return cc_adapters("ollama", {
              name = "gemma3:12b",
              schema = {
                model = {
                  default = "gemma3:12b",
                },
                num_ctx = {
                  default = 16384,
                },
                num_predict = {
                  default = -1,
                },
              },
            })
          end,
          ---This is the issue-manager used to create github issues
          ["gemma3-4b-issue-manager:latest"] = function()
            return cc_adapters("ollama", {
              name = "issue-manager",
              schema = {
                model = {
                  default = "gemma3-4b-issue-manager:latest",
                },
              },
            })
          end,
          ---https://ollama.com/library/gemma3n/tags
          ["gemma3n:e4b"] = function()
            return cc_adapters("ollama", {
              name = "gemma3n:e4b",
              schema = {
                model = {
                  default = "gemma3n:e4b",
                },
                num_ctx = {
                  default = 16384,
                },
                num_predict = {
                  default = -1,
                },
              },
            })
          end,
        },
      },

      --https://github.com/olimorris/codecompanion.nvim
      sources = {
        per_file = {
          codecompanion = { "codecompanion" },
        },
      },

      display = {
        diff = {
          enabled = true,
          close_chat_at = 240,
          layout = "vertical",
          opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
          provider = "mini_diff",
        },
      },
    })
  end,
}
