# Debugging

## TLDR

DAP (Debug Adapter Protocol) client via `nvim-dap`. Two UIs installed side-by-side for comparison: `nvim-dap-view` (single-pane, keyboard-first) and `nvim-dap-ui` (multi-pane). Adapters auto-registered via `mason-nvim-dap`. TypeScript / JavaScript / Node / Chrome handled through `js-debug-adapter` (`nvim-dap-vscode-js` bridge). Go handled through `delve`. Test-level debugging via `neotest` with `strategy = "dap"`.

## Plugin layering

| Plugin | Role |
|---|---|
| `mfussenegger/nvim-dap` | Core: sessions, breakpoints, stepping, REPL |
| `jay-babu/mason-nvim-dap.nvim` | Auto-registers Mason-installed adapters into `dap.adapters` |
| `theHamsta/nvim-dap-virtual-text` | Treesitter inline variable values during a session |
| `igorlfs/nvim-dap-view` | Single-pane UI (breakpoints, scopes, watches, threads, exceptions, REPL) |
| `rcarriga/nvim-dap-ui` | Multi-pane UI (splits: scopes / stack+watches / repl+console) |
| `mxsdev/nvim-dap-vscode-js` | Bridges `js-debug-adapter`, registers `pwa-node` + `pwa-chrome` adapters |
| `nvim-neotest/neotest` (+ vitest, go adapters) | Test discovery + run + debug per test |

## Files

| Path | Purpose |
|---|---|
| `lua/config/plugins/nvim-dap*.lua` | Plugin specs (7 files) |
| `lua/config/plugins/neotest.lua` | neotest spec with vitest + go adapters |
| `lua/config/dap/init.lua` | Sign icons, event listeners, requires per-language configs |
| `lua/config/dap/typescript.lua` | pwa-node + pwa-chrome launch configs (fallback when no `.vscode/launch.json`) |
| `lua/config/dap/go.lua` | Delve launch configs: debug, debug_test, attach |
| `lua/config/lsp/tools.lua` | `debug_adapters` list (`delve`, `js-debug-adapter`) consumed by mason-tool-installer |

## Adapter binaries

Installed via Mason (managed by mason-tool-installer through `tools.debug_adapters`):

| Adapter | Language | Path |
|---|---|---|
| `delve` | Go | `~/.local/share/nvim/mason/packages/delve/dlv` |
| `js-debug-adapter` | JS / TS / Node / Chrome | `~/.local/share/nvim/mason/packages/js-debug-adapter/js-debug-adapter` |

To add another (e.g. Python via `debugpy`): append to `M.debug_adapters` in `lua/config/lsp/tools.lua`, run `:MasonToolsInstall`, add per-language launch configs under `lua/config/dap/`.

## Keymap reference — `<leader>b*` (debug)

| Key | Action |
|---|---|
| `<leader>bb` | Toggle breakpoint at cursor |
| `<leader>bB` | Set conditional breakpoint (prompt) |
| `<leader>bc` | Continue / start session (picks launch config from `dap.configurations[filetype]`) |
| `<leader>bi` | Step into |
| `<leader>bo` | Step over |
| `<leader>bO` | Step out |
| `<leader>br` | Toggle REPL |
| `<leader>bl` | Run last configuration |
| `<leader>bx` | Terminate session (x for eXit) |
| `<leader>bj` | List breakpoints in quickfix |
| `<leader>bw` | Add expression to watches |
| `<leader>bv` | Toggle nvim-dap-view UI |
| `<leader>bu` | Toggle nvim-dap-ui UI |

`<leader>d` stays as `vim.diagnostic.open_float` (LSP diagnostics) — not touched.

## Keymap reference — `<leader>T*` (test / neotest)

| Key | Action |
|---|---|
| `<leader>Tt` | Run nearest test |
| `<leader>Tf` | Run all tests in current file |
| `<leader>Td` | **Debug** nearest test (DAP session + breakpoints) |
| `<leader>To` | Open test output for last run |
| `<leader>Ts` | Toggle summary panel |

Capital T disambiguates from `<leader>t` toggle namespace (`ts`, `tv`, `tl`).

## Launch configs

Two mechanisms coexist:

**1. Per-project `.vscode/launch.json`.** `nvim-dap-vscode-js` reads this automatically for JS/TS projects. Any launch config VS Code uses just works.

**2. Lua fallback** in `lua/config/dap/typescript.lua` and `lua/config/dap/go.lua`. Used when no `.vscode/launch.json` is present. Selection prompt appears on `<leader>bc`.

TypeScript configs available in the Lua fallback:
- Launch current file with `tsx`, `ts-node`, or plain `node`
- Attach to a running Node process (pick from list)
- Debug Vitest tests in current file
- Launch Chrome against `http://localhost:3000` (frontend)

Go configs (all via delve):
- Debug current file
- Debug package (containing directory)
- Debug test at cursor
- Debug all tests in package
- Attach to process (pick from list)

## Common workflows

### Debug a Go function

1. Open the file. `<leader>bb` at the line you want to pause.
2. `<leader>bc` → select "Debug current file" or "Debug package".
3. Execution stops at the breakpoint. `<leader>bi`/`<leader>bo`/`<leader>bO` to step.
4. `<leader>bv` or `<leader>bu` to open a UI and see scopes / watches / stack.
5. `<leader>bx` when done.

### Debug a Vitest test

1. Open the test file. `<leader>bb` on the line inside your test.
2. `<leader>Td` — neotest runs the nearest test through DAP.
3. Breakpoint hits, debug session live.

### Attach to a running Node server

1. Start the server externally: `node --inspect ./server.js` (or `--inspect-brk` to pause on start).
2. In nvim: `<leader>bc` → select "Attach to Node process" → pick the PID.

### Debug a React app in Chrome

1. Start your dev server (`npm run dev`, port 3000).
2. `<leader>bc` on a React source file → "Launch Chrome against localhost" → Chrome opens.
3. Set breakpoints in `.tsx` files. Interact with the app; breakpoints hit.

## Troubleshooting

| Symptom | Fix |
|---|---|
| `<leader>bc` says "No configuration found for filetype" | Filetype not in `dap.configurations`. Add to `lua/config/dap/<lang>.lua` |
| Adapter not registered | `:MasonToolsInstall` (installs missing binaries). Restart nvim. |
| Breakpoints show `○` (rejected) instead of `●` | Source map issue. For TS/JS: verify `sourceMaps = true` in launch config + project builds source maps. |
| Node --inspect port already in use | Kill orphaned Node processes: `pkill -f 'node --inspect'` |
| dap-view and dap-ui splits collide | Only toggle one at a time. `<leader>bv` and `<leader>bu` don't auto-close the other. |

## Related

- [lsp.md](lsp.md) — LSP and DAP are separate protocols; LSP provides static analysis, DAP provides runtime introspection.
- [linting.md](linting.md) — LSP-first linting overview.
- Vault: `~/notes/zettl/__vault/mocs/moc-neovim-debugging.md` (personal knowledge base entry point)

## References

- nvim-dap docs: `:h nvim-dap`
- DAP spec: <https://microsoft.github.io/debug-adapter-protocol/>
- vscode-js-debug (js-debug-adapter): <https://github.com/microsoft/vscode-js-debug>
- delve: <https://github.com/go-delve/delve>
- neotest: <https://github.com/nvim-neotest/neotest>
