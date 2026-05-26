-- vale-ls (Vale language server — prose linting)
-- https://github.com/errata-ai/vale-ls
-- Settings: https://vale.sh/docs/topics/config
-- Install: Mason -> vale-ls (auto-installed via lua/config/plugins/mason.lua)
--
-- Not auto-attached. Vale's diagnostics caused display flicker in editor
-- buffers (e.g. COMMIT_EDITMSG, markdown drafts). We keep the config
-- registered but inert. Toggle on-demand for the current buffer via
-- <leader>tv (uses config.utils.toggle_lsp_server — same mechanism as
-- <leader>tt for tsgo).

return {
  cmd = { "vale-ls" },
  root_markers = { ".vale.ini", "_vale.ini", ".git" },
  filetypes = {},
}
