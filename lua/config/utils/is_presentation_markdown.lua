local M = {}

--[[
Returns true if the current buffer is a presentation markdown.
Used to skip formatting and set conceallevel for *.presentation.md files.
]]
local is_presentation_markdown = function()
  local filename = vim.fn.expand("%")

  if filename:match(".*presentation.md") then
    vim.opt.conceallevel = 1
    return true
  else
    return false
  end
end

M.is_presentation_markdown = is_presentation_markdown

return M
