local M = {}

--[[
Returns true if the buffer is a presentation markdown file (*.presentation.md).
Used by conform.lua to skip format-on-save for those files. Pure predicate:
the presentation conceallevel is set by the BufEnter autocmd in utils/init.lua.
]]
---@param bufnr? integer defaults to the current buffer
---@return boolean
local is_presentation_markdown = function(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr or 0)
  return name:match("%.presentation%.md$") ~= nil
end

M.is_presentation_markdown = is_presentation_markdown

return M
