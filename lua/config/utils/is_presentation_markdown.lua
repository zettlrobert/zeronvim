local M = {}

---Whether the buffer is a presentation markdown file (*.presentation.md).
---conform.lua uses it to skip format-on-save. Pure predicate: the presentation
---conceallevel is set by the BufEnter autocmd in lua/config/autocmds.lua.
---@param bufnr? integer defaults to the current buffer
---@return boolean
local is_presentation_markdown = function(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr or 0)
  return name:match("%.presentation%.md$") ~= nil
end

M.is_presentation_markdown = is_presentation_markdown

return M
