-- https://github.com/nvim-treesitter/nvim-treesitter
--
-- The `main` branch of nvim-treesitter (Neovim 0.11+) drops the legacy module
-- system and leans on Neovim's native `vim.treesitter.*` API. There is no
-- `require("nvim-treesitter.configs").setup({ highlight = ..., indent = ... })`
-- anymore — we enable both per-buffer via a FileType autocmd.
--
-- The previous `master` branch was archived in October 2025; it contained the
-- bug behind the render-markdown nil-node crash on README files.

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup()

    -- Parsers to install (idempotent — `install()` skips already-present ones).
    -- Curated list rather than "all" (main branch removed the "all" shortcut).
    require("nvim-treesitter").install({
      "astro",
      "bash",
      "css",
      "dockerfile",
      "go",
      "graphql",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "nix",
      "prisma",
      "python",
      "regex",
      "rust",
      "scss",
      "sql",
      "svelte",
      "terraform",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    })

    -- Enable highlight + indent per buffer. pcall so a missing/broken parser
    -- doesn't break buffer loading — mirrors the defensiveness pattern in
    -- lua/config/lsp/init.lua.
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local bufnr = args.buf
        local ok = pcall(vim.treesitter.start, bufnr)
        if ok then
          vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
