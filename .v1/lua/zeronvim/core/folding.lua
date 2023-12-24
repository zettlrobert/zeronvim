local M = {}

-- open one fold under the cursor
M.openFoldUnderCursor = function()
  local key = "zo"
  vim.api.nvim_feedkeys(key, 'n', false)
end

-- open all folds under the cursor recursively
M.openAllFoldsUnderCursorRecursively = function()
  local key = "zO"
  vim.api.nvim_feedkeys(key, 'n', false)
end

-- close one fold under cursor
M.closeOneFoldUnderCursor = function()
  local key = "zc"
  vim.api.nvim_feedkeys(key, 'n', false)
end

-- close all folds under cursor recursively
M.closeAllFoldsUnderCursorRecursively = function()
  local key = "zC"
  vim.api.nvim_feedkeys(key, 'n', false)
end

-- when on closed fold, open it
M.openOnClosedFold = function()
  local key = "za"
  vim.api.nvim_feedkeys(key, 'n', false)
end

-- when on closed fold, open it recursively
M.openOnClosedFoldRecursively = function()
  local key = "zA"
  vim.api.nvim_feedkeys(key, 'n', false)
end

-- update all folds, thing about integration, for bufenter
M.updateFolds = function()
  local key = "zx"
  vim.api.nvim_feedkeys(key, 'n', false)
end

-- close all folds
M.closeAllFolds = function()
  local key = "zM"
  vim.api.nvim_feedkeys(key, 'n', false)
end

-- open all folds
M.openAllFolds = function()
  local key = "zR"
  vim.api.nvim_feedkeys(key, 'n', false)
  vim.notify("Folding")
end

return M
