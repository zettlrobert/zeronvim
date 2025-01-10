local M = {}

M.WindowTitle = {
  project = " ",
  file = " ",
}

M.Diagnostics = {
  ERROR = "",
  WARN = "",
  HINT = "",
  INFO = "",
}

M.Tree = {
  default = "",
  symlink = "",
  bookmark = "",
  symlink_arrow = " ➛ ",
  Folder = {
    ARROW_CLOSED = "",
    ARROW_OPEN = "",
    DEFAULT = "",
    OPEN = "",
    EMPTY = "",
    EMPTY_OPEN = "",
    SYMLINK = "",
  },
  Git = {
    unstaged = "✗",
    staged = "✓",
    unmerged = "",
    renamed = "➜",
    untracked = "★",
    deleted = "",
    ignored = "◌",
  },
}

M.TodoComments = {
  Bug = " ",
  Info = " ",
  Hack = " ",
  Warn = " ",
  Perf = "",
  Note = " ",
  Test = "⏲ ",
}

return M
