-- https://github.com/hrsh7th/nvim-cmp - completion engine
-- https://github.com/L3MON4D3/LuaSnip - snippet engine for lua - source
-- https://github.com/saadparwaiz1/cmp_luasnip - source for snippets
-- https://github.com/hrsh7th/cmp-nvim-lsp - source for lsp completion
-- https://github.com/rafamadriz/friendly-snippets - source for snippets
-- https://github.com/hrsh7th/cmp-path - source for filesystem paths
-- https://github.com/hrsh7th/cmp-cmdline - nvim-cmp source for vim's cmdline
-- https://github.com/hrsh7th/cmp-nvim-lua - nvim-cmp source for neovim Lua API.
-- https://github.com/hrsh7th/cmp-buffer -- nvim-cmp source for buffer words
-- https://github.com/hrsh7th/cmp-calc -- nvim-cmp source for math calculation.
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-calc",
  },
  config = function()
    local icons = require("icons")
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    -- Load Snippets from friendly-snippets into luasnip
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }),

      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = "nvim_lua" },
        { name = 'luasnip' },
        { name = "path" },
        { name = "buffer" },
        { name = "treesitter" },
        { name = "omni" },
        { name = "nvim_lsp_signature_help" },
        { name = "conventionalcommits" },
        { name = "calc" },
        { name = "codeium" }
      }, {
        { name = 'buffer' },
      }),

      formatting = {
        fields = { "kind", "abbr", "menu" },
        -- Formatting function for the `vim_item` object, which represents an entry in the completion menu.
        format = function(entry, vim_item)
          vim_item.kind = string.format('%s %s', icons.kind[vim_item.kind], vim_item.kind)
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            nvim_lua = "[NVIM_LUA]",
            luasnip = "[SNIP]",
            buffer = "[BUF]",
            path = "[PATH]",
            treesitter = "[TREESITTER]",
            codeium = "[AI]",
            calc = "[CALC]",
            omni = "[OMNI]"
          })[entry.source.name]
          return vim_item
        end,
      },

      experimental = {
        ghost_text = true
      }
    })
  end
}
