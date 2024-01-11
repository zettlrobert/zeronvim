-- https://github.com/folke/todo-comments.nvim
return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local todo_comments = require("todo-comments")
    local icons = require("icons")
    local keymap = vim.keymap.set

    todo_comments.setup({
      keywords = {
        -- can be a hex color, or a named color (see below)
        FIX = { icon = icons.todo_comments.Bug, color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = icons.todo_comments.Info, color = "info", alt = { "TASK" } },
        HACK = { icon = icons.todo_comments.Hack, color = "warning" },
        WARN = { icon = icons.todo_comments.Warn, color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = icons.todo_comments.Perf, alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = icons.todo_comments.Note, color = "hint", alt = { "INFO" } },
        TEST = { icon = icons.todo_comments.Test, color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
    })
  end
}
