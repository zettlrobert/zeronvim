local M = {}

M.mason = {
  package_installed = "✓",
  package_pending = "➜",
  package_uninstalled = "✗"
}

M.kind = {
  Array = "",
  Boolean = "",
  Class = "",
  Color = "",
  Constant = "",
  Constructor = "",
  Enum = "",
  EnumMember = "",
  Event = "",
  Field = "",
  File = "",
  Folder = "󰉋",
  Function = "",
  Interface = "",
  Key = "",
  Keyword = "",
  Method = "",
  Module = "",
  Namespace = "",
  Null = "󰟢",
  Number = "",
  Object = "",
  Operator = "",
  Package = "",
  Property = "",
  Reference = "",
  Snippet = "",
  String = "",
  Struct = "",
  Text = "",
  TypeParameter = "",
  Unit = "",
  Value = "",
  Variable = "",
  Codeium = ""
}

M.diagnostics = {
  signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }
}

M.todo_comments = {
  Bug = " ",
  Info = " ",
  Hack = " ",
  Warn = " ",
  Perf = "",
  Note = " ",
  Test = "⏲ "
}

return M
