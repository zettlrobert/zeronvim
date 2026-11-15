# Debugging

## TLDR

`nvim-dap` is the DAP (Debug Adapter Protocol) client. It loads on the first `<leader>b*` or `<leader>td*` keypress.

| Part | Setup |
|---|---|
| UIs | `nvim-dap-view` (single pane, keyboard-first) and `nvim-dap-ui` (multi-pane), side by side for comparison |
| Adapters | `mason-nvim-dap` registers delve and debugpy; `lua/config/dap/typescript.lua` registers js-debug-adapter |
| Languages | **Python** (debugpy), **Go** (delve), **TS/JS/Node/Chrome** (js-debug-adapter), **Lua in Neovim itself** (one-small-step-for-vimkind) |
| Tests | `neotest` with `strategy = "dap"` (`<leader>Td`) |

## Getting started (never used a debugger before?)

A debugger **pauses your code at a line**. You then read the real values of variables, step one line at a time, and
continue when ready. Instead of guessing why a function returned wrong data, you see each intermediate value and where
it diverged.

### The mental model

1. **Set a breakpoint**: mark a line where you want execution to pause.
2. **Start the session**: pick a launch config; nvim spawns your program under the debugger.
3. **Wait for the breakpoint to hit**: execution stops at your marked line.
4. **Inspect**: look at variables, call stack, expressions in the REPL.
5. **Step or continue**: step to the next line, or resume until the next breakpoint.
6. **End**: the session finishes naturally, or you terminate it.

### Core keymaps (memorize these five first)

| Key | Purpose | When to use |
|---|---|---|
| `<leader>bb` | Toggle **b**reakpoint at cursor | Put it on a line you want to pause at |
| `<leader>bc` | **C**ontinue / start session | Kicks off the debugger; also resumes execution after a pause |
| `<leader>bo` | Step **o**ver | Run the current line and stop at the next; don't dive into function calls |
| `<leader>bi` | Step **i**nto | Follow a function call one level deeper |
| `<leader>bx` | Terminate (e**x**it) | End the session |

Everything else is optional: `<leader>bB` conditional breakpoint, `<leader>br` REPL, `<leader>tdv` debug panel.

### Walkthrough: debug a Python file

Given `example.py`:

```python
def greet(name):
    message = "Hello, " + name
    return message

def main():
    user = "world"
    print(greet(user))

main()
```

1. Open `example.py` in nvim.
2. Move cursor to the line `message = "Hello, " + name` inside `greet`. Press `<leader>bb`. A red `●` appears in the
   sign column.
3. Press `<leader>bc`. A picker opens with Python launch configs (from `lua/config/dap/python.lua`). Pick **"Launch
   current file"**.
4. Execution stops **at your breakpoint**. The `▶` sign highlights the current line.
5. Press `<leader>tdv` to open the debug panel (dap-view, opens on **Scopes**). Its tabs include:
   - **Scopes**: locals (`name = "world"`) and globals
   - **Threads**: the call stack (`greet` called by `main`)
   - **Breakpoints**: every breakpoint
6. Press `<leader>bo` to step over. `message` gets assigned; the panel updates to show `message = "Hello, world"`.
7. Press `<leader>br` to open the REPL. Type `name.upper()` and press Enter: you get `"WORLD"`. Any variable in scope
   works.
8. Press `<leader>bc` again to continue. The program finishes and prints `"Hello, world"`.
9. Press `<leader>bx` (or just let it finish) to close the session.

Everything else is a variation on this loop: other languages, other breakpoint kinds, attaching to running processes.

### What the two UIs show

- **`<leader>tdv` (dap-view)**: one split with tabs (watches, scopes, exceptions, breakpoints, threads, repl, console).
  Keyboard-first. Recommended default.
- **`<leader>tdu` (dap-ui)**: fixed panels around the editor. More space, harder to navigate.

Neither opens automatically. Do not open both at once: the panels stack awkwardly.

### When it doesn't "just work"

- **"No configuration found for filetype"**: the language is not wired up yet. See [Adapter binaries](#adapter-binaries)
  for adding one.
- **Breakpoint shows `○` instead of `●`**: the debugger sees the file but can't map the breakpoint to a source line. For
  TS/JS: source maps. For Python: usually a stale `.pyc`; delete `__pycache__` and retry.
- **Session never starts**: check `<leader>nh` (notifier history). The adapter binary may be missing; check `:Mason`.
- **Wrong Python interpreter**: set `VIRTUAL_ENV` before starting nvim, or activate the venv. See "Python" section below
  for interpreter selection order.

## Plugin layering

| Plugin | Role |
|---|---|
| `mfussenegger/nvim-dap` | Core: sessions, breakpoints, stepping, REPL |
| `jay-babu/mason-nvim-dap.nvim` | Auto-registers Mason-installed adapters into `dap.adapters` |
| `theHamsta/nvim-dap-virtual-text` | Treesitter inline variable values during a session |
| `igorlfs/nvim-dap-view` | Single-pane UI (breakpoints, scopes, watches, threads, exceptions, REPL) |
| `rcarriga/nvim-dap-ui` | Multi-pane UI (splits: scopes / stack+watches / repl+console) |
| `nvim-neotest/neotest` (+ vitest, go adapters) | Test discovery + run + debug per test |

## Files

| Path | Purpose |
|---|---|
| `lua/config/plugins/nvim-dap.lua` | Core spec; its `config` loads `config.dap`, then the add-ons below |
| `lua/config/plugins/nvim-dap-{ui,view,virtual-text}.lua` | UI and virtual-text specs |
| `lua/config/plugins/mason-nvim-dap.lua` | Adapter registration (no installs) |
| `lua/config/plugins/one-small-step-for-vimkind.lua` | osv spec (Lua/nvim debug adapter) |
| `lua/config/plugins/neotest.lua` | neotest spec with vitest + go adapters |
| `lua/config/dap/init.lua` | Sign icons, requires the per-language configs |
| `lua/config/dap/typescript.lua` | Registers the `pwa-*` adapters (Mason `js-debug-adapter`, plus `node`/`chrome`/`msedge` aliases for VS Code configs) and the fallback launch configs |
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
| `osv` (in-process) | Lua (nvim runtime) | Plugin `one-small-step-for-vimkind`, no external binary |

To add another: append to `M.debug_adapters` in `lua/config/lsp/tools.lua`, run `:MasonToolsInstall`, add launch configs
in `lua/config/dap/<lang>.lua`, and `require` that file from `lua/config/dap/init.lua`.

## Keymap reference: `<leader>b*` (debug)

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
| `<leader>tdv` | Toggle nvim-dap-view |
| `<leader>tdu` | Toggle nvim-dap-ui |

The namespace is `b`, not `d`, because `<leader>d` is the diagnostic float.

## Keymap reference: `<leader>T*` (test / neotest)

| Key | Action |
|---|---|
| `<leader>Tt` | Run nearest test |
| `<leader>Tf` | Run all tests in current file |
| `<leader>Td` | **Debug** nearest test (DAP session + breakpoints) |
| `<leader>To` | Open test output for last run |
| `<leader>Ts` | Toggle summary panel |

Capital `T` keeps tests apart from the `<leader>t` toggle namespace.

## Launch configs

`<leader>bc` offers configs from two sources in one picker:

1. **Per-project `.vscode/launch.json`**, read by nvim-dap itself (its `dap.launch.json` provider). Legacy
   `node`/`chrome`/`msedge` types map to js-debug's `pwa-*` types.
2. **Lua configs** in `lua/config/dap/{typescript,go,python,lua}.lua`, always available.

TypeScript / JavaScript (`typescript`, `typescriptreact`, `javascript`, `javascriptreact`):

- Launch current file (tsx), (ts-node), (node)
- Attach to Node process (pick from list)
- Debug Vitest current file
- Launch Chrome against localhost (`http://localhost:3000`)

Go (delve):

- Debug current file
- Debug package (containing directory)
- Debug test (at cursor): `mode = "test"` on the current file
- Debug test package (all)
- Attach to process (pick from list)

## Python

Configs in `lua/config/dap/python.lua`. Interpreter selection order (via `get_python_path`):

1. `$VIRTUAL_ENV/bin/python` (if a venv is active)
2. `$CONDA_PREFIX/bin/python` (if a conda env is active)
3. `<cwd>/venv/bin/python`, `<cwd>/.venv/bin/python`, `<cwd>/env/bin/python` (whichever exists)
4. `python3`, else `python`

Your code runs in the project's env, not Mason's isolated debugpy env, so imports resolve.

Configs available:

- Launch current file
- Launch current file (with args): prompts for space-separated args
- Launch module (python -m ...): prompts for the module name
- Debug pytest (current file): `pytest <file> -vv -s`
- Debug pytest at cursor: `pytest <file>::<selected text>`; select the test name first
- Attach to running process

The pytest configs set `justMyCode = false`, so you can step into fixtures and conftest helpers.

## Lua (Neovim's own runtime)

Debug nvim config or plugin code with `one-small-step-for-vimkind` (osv). It needs two nvim instances:

1. **Server nvim**, the one to debug. Run:

   ```vim
   :lua require("osv").launch({ port = 8086 })
   ```

   osv opens a DAP server on port 8086 inside that nvim.
2. **Client nvim**: open the `.lua` file, `<leader>bb` at a line, `<leader>bc` → "Attach to nvim (osv)".
3. Trigger the code in the server nvim (call the function, press the keymap). Execution pauses; step and inspect from
   the client.
4. `<leader>bx` in the client to detach.

Shortcut: `:lua require("osv").run_this()` in the server nvim runs the current buffer's Lua under the debugger right
away.

Standalone Lua (outside nvim) needs a different debugger (`local-lua-debugger-vscode`), not set up here.

## Common workflows

### Debug a Go function

1. Open the file. `<leader>bb` at the line you want to pause.
2. `<leader>bc` → select "Debug current file" or "Debug package".
3. Execution stops at the breakpoint. `<leader>bi`/`<leader>bo`/`<leader>bO` to step.
4. `<leader>tdv` or `<leader>tdu` to see scopes, watches and the stack.
5. `<leader>bx` when done.

### Debug a Vitest test

1. Open the test file. `<leader>bb` on the line inside your test.
2. `<leader>Td`: neotest runs the nearest test through DAP.
3. Breakpoint hits, debug session live.

### Attach to a running Node server

1. Start the server externally: `node --inspect ./server.js` (or `--inspect-brk` to pause on start).
2. In nvim: `<leader>bc` → select "Attach to Node process" → pick the PID.

### Debug a React app in Chrome

1. Start your dev server (`npm run dev`, port 3000).
2. `<leader>bc` on a React source file → "Launch Chrome against localhost" → Chrome opens.
3. Set breakpoints in `.tsx` files. Interact with the app; breakpoints hit.

### Debug a Python script

1. Activate your venv before starting nvim (`source .venv/bin/activate`), or keep a `.venv/` in the project root.
2. Open the `.py` file. `<leader>bb` at the line you want to pause.
3. `<leader>bc` → "Launch current file".
4. Session starts using your venv's Python. Step / inspect as usual.

### Debug a pytest test

1. Open the test file. `<leader>bb` at the line of interest inside the test.
2. `<leader>bc` → "Debug pytest (current file)".
3. Session runs `pytest <file> -vv -s`; breakpoint hits.

### Debug your nvim config (Lua)

See [Lua (Neovim's own runtime)](#lua-neovims-own-runtime). Example target: a function in
`lua/config/utils/ai_toggle.lua`, triggered with `<leader>ap` in the server nvim.

## Troubleshooting

| Symptom | Fix |
|---|---|
| `<leader>bc` says "No configuration found for filetype" | Filetype not in `dap.configurations`. Add to `lua/config/dap/<lang>.lua` |
| Adapter not registered | `:MasonToolsInstall` (installs missing binaries). Restart nvim. |
| Breakpoints show `○` (rejected) instead of `●` | Source map issue. For TS/JS: verify `sourceMaps = true` in launch config + project builds source maps. |
| Node --inspect port already in use | Kill orphaned Node processes: `pkill -f 'node --inspect'` |
| dap-view and dap-ui splits collide | Open one at a time. `<leader>tdv` and `<leader>tdu` do not close the other. |
| Python `ModuleNotFoundError` under debug | Wrong interpreter: set `VIRTUAL_ENV` before starting nvim, or create `.venv/` in project root; `get_python_path` will pick it up. |
| Python breakpoints ignored | Stale `.pyc` files in `__pycache__`: delete and retry. |
| osv "Connection refused" | Server nvim didn't call `require("osv").launch({...})` yet, or the port is different from the client's config (default 8086). |
| osv breakpoint doesn't hit | The code has not run in the server nvim yet. osv pauses only when the marked line executes there. |

## Related

- [lsp.md](lsp.md) - LSP gives static analysis; DAP gives runtime introspection. Separate protocols.
- [keymaps.md](keymaps.md) - full keymap reference.
- Vault: `~/notes/zettl/__vault/mocs/moc-neovim-debugging.md` - personal knowledge base entry point.

## References

- nvim-dap docs: `:h nvim-dap`
- DAP spec: <https://microsoft.github.io/debug-adapter-protocol/>
- vscode-js-debug (js-debug-adapter): <https://github.com/microsoft/vscode-js-debug>
- delve: <https://github.com/go-delve/delve>
- debugpy: <https://github.com/microsoft/debugpy>
- one-small-step-for-vimkind (osv): <https://github.com/jbyuki/one-small-step-for-vimkind>
- neotest: <https://github.com/nvim-neotest/neotest>
