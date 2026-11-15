--https://github.com/rafamadriz/friendly-snippets

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
    "saghen/blink.cmp",
    -- The `omni` source is blink's built-in blink.cmp.sources.complete_func,
    -- so neither cmp-omni nor the blink.compat bridge is needed.
    dependencies = {
      "rafamadriz/friendly-snippets",
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
        nerd_font_variant = "mono",
        kind_icons = {
          copilot = "",
          minuet = "",
        },
      },

      -- Show signature. Blink's signature window doesn't inherit
      -- `vim.o.winborder`; it has its own border config that defaults to
      -- `"padded"`. Force `rounded` to match every other float in the config.
      signature = {
        enabled = true,
        window = { border = "rounded" },
      },

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
        -- A function so the AI sources are listed only while their provider
        -- is on. blink builds (requires) every listed provider before it
        -- checks `enabled`, so a static list would load the lazy AI plugins on
        -- the first completion. See config.utils.ai_toggle.
        default = function()
          local ai = require("config.utils.ai_toggle")
          local sources = { "lsp", "path", "snippets", "buffer", "omni" }
          if ai.is_copilot_enabled() then
            table.insert(sources, "copilot")
          end
          if ai.is_minuet_enabled() then
            table.insert(sources, "minuet")
          end
          return sources
        end,

        -- render-markdown's source only matters in markdown, and listing it
        -- in `default` would load the ft-lazy plugin on the first completion
        -- in any filetype.
        per_filetype = {
          markdown = { "markdown", inherit_defaults = true },
        },

        -- CMP completion sources
        providers = {
          markdown = {
            name = "RenderMarkdown",
            module = "render-markdown.integ.blink",
          },


          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 100,
            async = true,
          },

          minuet = {
            -- Local AI completion via minuet-ai.nvim (see minuet-ai.lua).
            -- Timeout is generous — a 7B FIM request on Ollama can take
            -- 1–3s on CPU, faster on GPU.
            name = "minuet",
            module = "minuet.blink",
            async = true,
            timeout_ms = 3000,
            score_offset = 50,
          },
        },
      },
    },
    -- No opts_extend for sources.default: it is a function (see above), and
    -- no other spec extends it.
  },
}
