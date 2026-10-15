-- https://github.com/mfussenegger/nvim-lint
-- Runs external linters that aren't LSP servers and surfaces their output
-- via vim.diagnostic. Complements conform.nvim (formatting) and the LSP
-- servers configured under lsp/.
--
-- Filetypes with LSP-based linting (eslint, vale_ls, tflint) are intentionally
-- omitted here — no double diagnostics.
--
-- Linter binaries are installed via Mason from lua/config/lsp/tools.lua.

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile", "BufWritePost" },
  config = function()
    local lint = require("lint")
    local toggle = require("config.utils.toggle_linter")
    local kd = require("config.utils.keymap_desc")
    local K, T = kd.KIND, kd.TOOL
    local group = vim.api.nvim_create_augroup("NvimLintTrigger", { clear = true })

    lint.linters_by_ft = {
      markdown = { "markdownlint-cli2" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
      dockerfile = { "hadolint" },
      yaml = { "yamllint" },
      -- nvim-lint's built-in linter name is `golangcilint` (no dash);
      -- the Mason binary is `golangci-lint` (with dash). Two different names
      -- for the same tool.
      go = { "golangcilint" },
      python = { "ruff" },
      lua = { "selene" },
    }

    -- Lint like the git hooks (github:zettlrobert/githooks): use the profile's copy of each shared linter when
    -- present, so the version matches the hooks; Mason's copy stays the fallback on machines without it.
    -- Only these linters: a global Mason PATH = "append" would also swap LSPs and formatters (rust-analyzer,
    -- ruff, tsgo) for older or broken copies on PATH.
    local profile_bin = vim.fn.expand("~/.nix-profile/bin/")
    for _, name in ipairs({ "shellcheck", "yamllint", "hadolint", "actionlint", "markdownlint-cli2" }) do
      if vim.fn.executable(profile_bin .. name) == 1 then
        lint.linters[name].cmd = profile_bin .. name
      end
    end

    -- markdownlint-cli2 has no user config: start from the shared rules. A repo .markdownlint-cli2.yaml still
    -- merges on top (found from the working directory). Without the profile it uses its defaults.
    local md_rules = vim.fn.expand("~/.nix-profile/share/githooks/markdownlint.yaml")
    if vim.fn.filereadable(md_rules) == 1 then
      lint.linters["markdownlint-cli2"].args = { "--config", md_rules, "-" }
    end

    -- Filetype-based trigger: runs whichever linters are configured for the
    -- ft, filtered through `toggle_linter` so per-linter disables stick.
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
      group = group,
      callback = function()
        local linters = lint.linters_by_ft[vim.bo.filetype] or {}
        local enabled = toggle.filter(linters)
        if #enabled > 0 then
          lint.try_lint(enabled)
        end
      end,
    })

    -- Path-based trigger: actionlint only fires for GitHub workflow YAMLs to
    -- avoid false positives on other YAML files (Kubernetes manifests, etc.).
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
      group = group,
      pattern = { "*/.github/workflows/*.yml", "*/.github/workflows/*.yaml" },
      callback = function()
        if toggle.is_enabled("actionlint") then
          lint.try_lint("actionlint")
        end
      end,
    })

    -- <leader>t namespace (toggle)
    vim.keymap.set("n", "<leader>tm", function()
      toggle.toggle("markdownlint-cli2")
    end, { desc = kd.format(K.TOGGLE, T.Markdownlint, "linter") })
  end,
}
