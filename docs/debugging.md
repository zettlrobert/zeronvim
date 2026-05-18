# Debugging

## TLDR

**Not yet set up.** This config currently has no DAP integration. This doc is a roadmap for the upcoming setup, not a working reference.

## Planned scope

| Language / runtime | Adapter |
|---|---|
| TypeScript / JavaScript (Node) | [`vscode-js-debug`](https://github.com/microsoft/vscode-js-debug) via `js-debug-adapter` (Mason) |
| TypeScript / JavaScript (browser) | Same adapter, browser launch config (Chrome / Firefox) |
| Go | [`delve`](https://github.com/go-delve/delve) — already listed in `lua/config/lsp/tools.lua` (`debug_adapters.delve`) |

## Components to wire up

| Plugin | Role |
|---|---|
| `mfussenegger/nvim-dap` | Core DAP client — required |
| `rcarriga/nvim-dap-ui` | UI panels for breakpoints, scopes, watches, call stack |
| `theHamsta/nvim-dap-virtual-text` | Inline variable values via treesitter |
| `jay-babu/mason-nvim-dap.nvim` | Bridge between Mason install and DAP adapter registration |
| `mxsdev/nvim-dap-vscode-js` | Bridge between `js-debug-adapter` and nvim-dap (JS/TS only) |

`delve` is already on the Mason install list; `js-debug-adapter` needs to be added to `tools.lua > debug_adapters` when we wire this up.

## Open questions for the planning session

- Launch config style: per-project `.vscode/launch.json` (compat), or lua tables in a `dap/` directory?
- Browser debugging — Chrome vs Firefox, attach vs launch?
- Test debugging — should it be wired into a test runner (jest, vitest, go test) launch config?
- Keymaps — share with which-key group? `<leader>d*` is currently unused except `<leader>d` (open_float) — that may need to move.

## References

- nvim-dap docs: `:h nvim-dap`
- DAP spec: <https://microsoft.github.io/debug-adapter-protocol/>
- vscode-js-debug README: <https://github.com/microsoft/vscode-js-debug>

## Related

- [lsp.md](lsp.md) — LSP and DAP are separate protocols; LSP provides static analysis, DAP provides runtime introspection.
