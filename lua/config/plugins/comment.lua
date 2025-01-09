return {
  "numToStr/Comment.nvim",
  dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  config = function()
    local comment = require("Comment")

    comment.setup({
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      padding = true,
      sticky = true,
      ignore = 'nil',
      mappings = {
        basic = true,
        extra = true
      },
      toggler = {
        block = 'gbc',
        line = 'gcc'
      },
      post_hook = function()
        return
      end,
      extra = {
        above = 'gcO',
        below = 'gco',
        eol = 'gcA'
      },
      opleader = {
        block = 'gb',
        line = 'gc'
      }
    })
  end
}
