-- https://github.com/numToStr/Comment.nvim
-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring#commentnvim
return {
  'numToStr/Comment.nvim',
  dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  config = function()
    local comment = require("Comment")
    local nvim_ts_context_commentstring = require("ts_context_commentstring")

    -- Disable the treesitter default autocommand to toggle it with comment
    nvim_ts_context_commentstring.setup({
      enable_autocmd = false,
    })

    -- Integrate nvim_ts_context_commentstring into comment
    comment.setup({
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
    })
 end
}
-- `gcc` - Toggles the current line using linewise comment
-- `gbc` - Toggles the current line using blockwise comment
-- `[count]gcc` - Toggles the number of line given as a prefix-count using linewise
-- `[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
-- `gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
-- `gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment
