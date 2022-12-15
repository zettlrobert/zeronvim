local M = {}

M.prettier_opts = {
  {
    prefer_local = "node_modules/.bin"
  },
  {
    extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" }
  }
}

return M
