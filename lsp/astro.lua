-- astro-language-server
-- https://github.com/withastro/language-tools
-- Install: Mason -> astro-language-server
-- :h lsp-config

local function is_astro_ls_installed()
  return vim.fn.executable("astro-ls") == 1
end

if is_astro_ls_installed() == false then
  vim.notify(
    "astro-ls is not installed. Install via Mason (:Mason -> astro-language-server) to enable Astro LSP support.",
    vim.log.levels.ERROR
  )
  return
end

return {
  cmd = { "astro-ls", "--stdio" },
  filetypes = { "astro" },
  root_markers = { "astro.config.mjs", "astro.config.ts", "package.json", ".git" },
}
