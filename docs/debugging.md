# Debugging

## TLDR

DAP (Debug Adapter Protocol) client via `nvim-dap`. Two UIs installed side-by-side for comparison: `nvim-dap-view` (single-pane, keyboard-first) and `nvim-dap-ui` (multi-pane). Adapters auto-registered via `mason-nvim-dap`. Languages currently wired: **Python** (debugpy), **Go** (delve), **TS/JS/Node/Chrome** (js-debug-adapter via `nvim-dap-vscode-js` bridge), and **Lua for Neovim's own runtime** (one-small-step-for-vimkind). Test-level debugging via `neotest` with `strategy = "dap"`.

## Getting started (never used a debugger before?)

A debugger lets you **pause your code at a specific line**, then look at the actual values of variables at that moment, step forward one line at a time, and continue when you're ready. It's the difference between "the function returned wrong data — why?" and "here's the exact input, here's what each intermediate value is, here's where it diverged from what I expected."

### The mental model

1. **Set a breakpoint** — mark a line where you want execution to pause.
2. **Start the session** — pick a launch config; nvim spawns your program under the debugger.
3. **Wait for the breakpoint to hit** — execution stops at your marked line.
4. **Inspect** — look at variables, call stack, expressions in the REPL.
5. **Step or continue** — step to the next line, or resume until the next breakpoint.
6. **End** — session finishes naturally, or you terminate it.

### Core keymaps (memorize these five first)

| Key | Purpose | When to use |
|---|---|---|
| `<leader>bb` | Toggle **b**reakpoint at cursor | Put it on a line you want to pause at |
| `<leader>bc` | **C**ontinue / start session | Kicks off the debugger; also resumes execution after a pause |
| `<leader>bo` | Step **o**ver | Run the current line and stop at the next; don't dive into function calls |
| `<leader>bi` | Step **i**nto | Follow a function call one level deeper |
| `<leader>bx` | Terminate (e**x**it) | End the session |

Once those feel natural, everything else (`<leader>bB` conditional breakpoint, `<leader>br` REPL, `<leader>bv` open UI panel) is optional flavor.

### Concrete walkthrough — debug a Python file

Say you have `example.py`:

```python
def greet(name):
    message = "Hello, " + name
    return message

def main():
    user = "world"
    print(greet(user))

main()
```

Suppose `greet` returns something unexpected and you want to see what.

1. Open `example.py` in nvim.
2. Move cursor to the line `message = "Hello, " + name` inside `greet`. Press `<leader>bb`. A red `●` appears in the sign column.
3. Press `<leader>bc`. A picker opens with Python launch configs (from `lua/config/dap/python.lua`). Pick **"Launch current file"**.
4. Execution stops **at your breakpoint**. The `▶` sign highlights the current line.
5. Press `<leader>bv` to open the debug panel. You'll see:
   - **Scopes** — locals (`name = "world"`) and globals
   - **Stack** — where in the call chain you are (`greet` was called by `main`)
   - **Breakpoints** — the list of all breakpoints
6. Press `<leader>bo` to step over. `message` gets assigned; the panel updates to show `message = "Hello, world"`.
7. Press `<leader>br` to open the REPL. Type `name.upper()` and hit enter — you get `"WORLD"` back. You can call methods on any variable in scope.
8. Press `<leader>bc` again to continue. The program finishes and prints `"Hello, world"`.
9. Press `<leader>bx` (or just let it finish) to close the session.

That's it. Everything else is variations on this loop for other languages, other kinds of breakpoints, or attaching to already-running processes.

### What the two UIs show

- **`<leader>bv` (dap-view)** — single window with tabs (Scopes / Stack / Watches / REPL). Keyboard-first. Recommended default.
- **`<leader>bu` (dap-ui)** — splits the screen into fixed panels. More visual space, harder to navigate. Try both; pick your preference.

Don't open both at once — the panels stack awkwardly.

### When it doesn't "just work"

- **"No configuration found for filetype"** — the language isn't wired up yet. See "Add another language" below.
- **Breakpoint icon shows `○` instead of `●`** — the debugger sees the file but can't map the breakpoint to a source line. For TS/JS: source maps. For Python: usually a stale `.pyc` — delete `__pycache__` and retry.
- **Session never starts** — check `<leader>nh` (notifier history) for errors. Adapter binary might be missing — `:Mason` to check + install.
- **Wrong Python interpreter** — set `VIRTUAL_ENV` before starting nvim, or activate the venv. See "Python" section below for interpreter selection order.

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
| `lua/config/plugins/one-small-step-for-vimkind.lua` | osv plugin spec (Lua/nvim debug adapter) |
| `lua/config/plugins/neotest.lua` | neotest spec with vitest + go adapters |
| `lua/config/dap/init.lua` | Sign icons, event listeners, requires per-language configs |
| `lua/config/dap/typescript.lua` | pwa-node + pwa-chrome launch configs (fallback when no `.vscode/launch.json`) |
| `lua/config/dap/go.lua` | Delve launch configs: debug, debug_test, attach |
| `lua/config/dap/python.lua` | debugpy launch configs: launch file, module, pytest, attach |
| `lua/config/dap/lua.lua` | osv attach config for debugging nvim's own Lua |
| `lua/config/lsp/tools.lua` | `debug_adapters` list (`delve`, `js-debug-adapter`, `debugpy`) consumed by mason-tool-installer |

## Adapter binaries

Installed via Mason (managed by mason-tool-installer through `tools.debug_adapters`):

| Adapter | Language | Path |
|---|---|---|
| `delve` | Go | `~/.local/share/nvim/mason/packages/delve/dlv` |
| `js-debug-adapter` | JS / TS / Node / Chrome | `~/.local/share/nvim/mason/packages/js-debug-adapter/js-debug-adapter` |
| `debugpy` | Python | `~/.local/share/nvim/mason/packages/debugpy/venv/bin/python` |
| `osv` (in-process) | Lua (nvim runtime) | plugin: `one-small-step-for-vimkind` — no external binary |

To add another: append to `M.debug_adapters` in `lua/config/lsp/tools.lua`, run `:MasonToolsInstall`, add per-language launch configs under `lua/config/dap/` (and `require` the file from `lua/config/dap/init.lua`).

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

## Python

Configs in `lua/config/dap/python.lua`. Interpreter selection order (via `get_python_path`):

1. `$VIRTUAL_ENV/bin/python` (if a venv is active)
2. `$CONDA_PREFIX/bin/python` (if a conda env is active)
3. `<cwd>/venv/bin/python`, `<cwd>/.venv/bin/python`, `<cwd>/env/bin/python` (whichever exists)
4. `python3` (system) as final fallback

This runs your code with your project's env, not Mason's isolated debugpy env — so imports resolve correctly.

Configs available:
- Launch current file
- Launch current file (with args) — prompts for space-separated args
- Launch module (`python -m <name>`) — prompts for module name
- Debug pytest (current file) — `pytest <file> -vv -s`
- Debug pytest at cursor — `pytest <file>::<selected>`; select the test name first
- Attach to running process

`justMyCode = false` on the pytest configs so you can step into fixtures / conftest helpers.

## Lua (Neovim's own runtime)

Debugging nvim config or plugin code via `one-small-step-for-vimkind` (osv). Requires two nvim instances:

1. **Server nvim** — the one you want to debug. Run:
   ```
   :lua require("osv").launch({ port = 8086 })
   ```
   osv opens a DAP server on port 8086 inside that nvim.
2. **Client nvim** — open the `.lua` file, `<leader>bb` at a line, `<leader>bc` → "Attach to nvim (osv)".
3. Trigger the code in the server nvim (e.g., call your function, run a keymap). Execution pauses in the client with the standard step/inspect controls.
4. `<leader>bx` in the client to detach.

Convenience: in the server nvim, `:lua require("osv").run_this()` runs the current buffer's Lua under debug immediately — useful for testing standalone scripts.

Standalone Lua (outside nvim) uses a different debugger (`local-lua-debugger-vscode`) and is not set up here.

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

### Debug a Python script

1. Activate your venv before starting nvim (`source .venv/bin/activate`) — or ensure `.venv/` exists in the project root.
2. Open the `.py` file. `<leader>bb` at the line you want to pause.
3. `<leader>bc` → "Launch current file".
4. Session starts using your venv's Python. Step / inspect as usual.

### Debug a pytest test

1. Open the test file. Put cursor inside the test function body.
2. `<leader>bb` at the line of interest.
3. `<leader>bc` → "Debug pytest (current file)".
4. Session runs `pytest <file> -vv -s`; breakpoint hits.

### Debug your nvim config (Lua)

1. In the nvim instance you want to inspect: `:lua require("osv").launch({ port = 8086 })`
2. Open a **second** nvim in another terminal or split window.
3. In the second nvim: open a Lua file (e.g., `lua/config/utils/ai_toggle.lua`), `<leader>bb` on a line inside a function, `<leader>bc` → "Attach to nvim (osv)".
4. Trigger the function in the first nvim (e.g., press the keymap that calls it). It pauses in the second nvim.

## Troubleshooting

| Symptom | Fix |
|---|---|
| `<leader>bc` says "No configuration found for filetype" | Filetype not in `dap.configurations`. Add to `lua/config/dap/<lang>.lua` |
| Adapter not registered | `:MasonToolsInstall` (installs missing binaries). Restart nvim. |
| Breakpoints show `○` (rejected) instead of `●` | Source map issue. For TS/JS: verify `sourceMaps = true` in launch config + project builds source maps. |
| Node --inspect port already in use | Kill orphaned Node processes: `pkill -f 'node --inspect'` |
| dap-view and dap-ui splits collide | Only toggle one at a time. `<leader>bv` and `<leader>bu` don't auto-close the other. |
| Python `ModuleNotFoundError` under debug | Wrong interpreter — set `VIRTUAL_ENV` before starting nvim, or create `.venv/` in project root; `get_python_path` will pick it up. |
| Python breakpoints ignored | Stale `.pyc` files in `__pycache__` — delete and retry. |
| osv "Connection refused" | Server nvim didn't call `require("osv").launch({...})` yet, or the port is different from the client's config (default 8086). |
| osv breakpoint doesn't hit | The code hasn't been triggered yet in the server nvim. osv only pauses when your marked line actually executes there. |

## Related

- [lsp.md](lsp.md) — LSP and DAP are separate protocols; LSP provides static analysis, DAP provides runtime introspection.
- [linting.md](linting.md) — LSP-first linting overview.
- Vault: `~/notes/zettl/__vault/mocs/moc-neovim-debugging.md` (personal knowledge base entry point)

## References

- nvim-dap docs: `:h nvim-dap`
- DAP spec: <https://microsoft.github.io/debug-adapter-protocol/>
- vscode-js-debug (js-debug-adapter): <https://github.com/microsoft/vscode-js-debug>
- delve: <https://github.com/go-delve/delve>
- debugpy: <https://github.com/microsoft/debugpy>
- one-small-step-for-vimkind (osv): <https://github.com/jbyuki/one-small-step-for-vimkind>
- neotest: <https://github.com/nvim-neotest/neotest>
