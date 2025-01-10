-- https://github.com/folke/todo-comments.nvim
return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local trouble = require("trouble")
    local todo_comments = require("todo-comments")
    local icons = require("config.assets.icons")

    todo_comments.setup({
      keywords = {
        FIX = {
          icon = icons.TodoComments.Bug,
          color = "error",
          alt = {
            "FIXME",
            "BUG",
            "FIXIT",
            "ISSUE",
          },
        },
        TODO = {
          icon = icons.TodoComments.Info,
          color = "info",
          alt = {
            "TASK",
          },
        },
        HACK = {
          icon = icons.TodoComments.Hack,
          color = "warning",
        },
        WARN = {
          icon = icons.TodoComments.Warn,
          color = "warning",
          alt = {
            "WARNING",
            "XXX",
          },
        },
        PERF = {
          icon = icons.TodoComments.Perf,
          alt = {
            "OPTIM",
            "PERFORMANCE",
            "OPTIMIZE",
          },
        },
        NOTE = {
          icon = icons.TodoComments.Note,
          color = "hint",
          alt = {
            "INFO",
          },
        },
        TEST = {
          icon = icons.TodoComments.Test,
          color = "test",
          alt = {
            "TESTING",
            "PASSED",
            "FAILED",
          },
        },
      },
    })

    vim.keymap.set("n", "<leader>todo", function()
      trouble.toggle({ mode = "todo" })
    end, { desc = ":Trouble toggle todos" })

    vim.keymap.set("n", "]t", function()
      require("todo-comments").jump_next()
    end, { desc = ":Trouble next todo comment" })

    vim.keymap.set("n", "[t", function()
      require("todo-comments").jump_prev()
    end, { desc = ":Trouble previous todo comment" })
  end,
}
