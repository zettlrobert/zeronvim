--https://github.com/rafamadriz/friendly-snippets
--https://github.com/hrsh7th/cmp-omni

--TODO: move to debug utils
local function dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end

return {
  {
    ---TODO: Move to dedicated plugin file
    ---https://github.com/tzachar/cmp-ai
    "tzachar/cmp-ai",
    config = function()
      local cmp_ai = require("cmp_ai.config")
      cmp_ai:setup({
        max_lines = 100,
        provider = "Ollama",
        provider_options = {
          model = "qwen2.5-coder:7b-base-q6_K",
          auto_unload = true,
          prompt = function(lines_before, lines_after)
            -- You may include filetype and/or other project-wise context in this string as well.
            -- Consult model documentation in case there are special tokens for this.
            return "<|fim_prefix|>" .. lines_before .. "<|fim_suffix|>" .. lines_after .. "<|fim_middle|>"
          end,
        },
        notify = true,
        notify_callback = function(msg)
          vim.notify(msg)
        end,
        run_on_every_keystroke = false,
      })
    end,
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "hrsh7th/cmp-omni",
      {
        ---https://github.com/saghen/blink.compat
        "saghen/blink.compat",
        version = "2.*",
        lazy = true,
      },
    },
    lazy = false,
    -- use a release tag to download pre-built binaries
    version = "*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = { preset = "default" },

      -- Disable for some filetypes
      enabled = function()
        return not vim.tbl_contains({ "oil" }, vim.bo.filetype)
            and vim.bo.buftype ~= "prompt"
            and vim.b.completion ~= false
      end,

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
        kind_icons = {
          codeium = "",
          copilot = "",
        },
      },

      -- Show signature
      signature = { enabled = true },

      completion = {
        -- Show documentation when selecting a completion item
        documentation = { auto_show = true, auto_show_delay_ms = 250 },

        -- Display a preview of the selected item on the current line
        ghost_text = { enabled = true },

        menu = {
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "kind_icon", "label",       "label_description", gap = 1 },
              { "kind",      "source_name", gap = 1 },
            },
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                  return kind_icon
                end,
                ---Optionally, you may also use the highlights from mini.icons
                highlight = function(ctx)
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
            },
          },
        },
      },
      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "omni",
          "markdown",
          "codeium",
          "copilot",
          -- NOTE: Disabled
          -- "ollama", --ollama
        },

        -- CMP completion sources
        providers = {
          markdown = {
            name = "RenderMarkdown",
            module = "render-markdown.integ.blink",
          },

          -- obsidian = {
          --   name = "obsidian",
          --   mdouel = "blink.compat.source"
          -- },

          codeium = {
            -- Same name as cmp source
            name = "codeium",
            module = "codeium.blink",
            async = true,
          },

          ollama = {
            name = "cmp_ai", --ollama
            module = "blink.compat.source",
          },

          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
