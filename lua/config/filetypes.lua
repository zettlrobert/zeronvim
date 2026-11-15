--[[
Filetype detection additions (:h vim.filetype.add).

Detection has to be registered at startup. An `after/ftplugin/<ft>.lua` only
runs once a buffer already has filetype <ft>, so it can never teach Neovim a
new extension: that is why the old after/ftplugin/tofu.lua never ran.
]]

vim.filetype.add({
  extension = {
    -- OpenTofu files use Terraform syntax. Neovim has no built-in `.tofu`
    -- detection, and the terraform filetype gets the treesitter parser and
    -- tofu_ls (see lsp/tofu_ls.lua).
    tofu = "terraform",
  },
  -- `.env*` files → shell. `filename` handles the exact `.env` case and beats
  -- Neovim's built-in `env` detection. `pattern` for the dot-suffixed
  -- variants (`.env.local`, `.env.production`, ...) needs an explicit
  -- `priority` bump to win over the built-in. The shell filetype gives useful
  -- highlighting for the `KEY=value` syntax.
  filename = {
    [".env"] = "sh",
  },
  pattern = {
    ["%.env%..*"] = { "sh", { priority = 100 } },
  },
})
