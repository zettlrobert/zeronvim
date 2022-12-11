local utils = require "zeronvim.utils"
local comment = utils.protected_plugin_call("Comment")
local ts_context_commentstring_utils = utils.protected_plugin_call("ts_context_commentstring.utils")
local ts_context_commentstring_internal = utils.protected_plugin_call("ts_context_commentstring.internal")

if comment and ts_context_commentstring_utils and ts_context_commentstring_internal then
  comment.setup({
    pre_hook = function(ctx)
      local U = require "Comment.utils"

      local location = nil

      if ctx.ctype == U.ctype.block then
        location = ts_context_commentstring_utils.get_cursor_location()
      elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
        location = ts_context_commentstring_utils.get_visual_start_location()
      end

      return ts_context_commentstring_internal.calculate_commentstring {
        key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
        location = location,
      }
    end
  })
end

