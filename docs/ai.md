# AI

## TLDR

Three complementary AI tools:

- **Copilot** — inline suggestions + completion (GitHub subscription, cloud)
- **Windsurf / Codeium** — inline suggestions + completion (free tier, cloud)
- **CodeCompanion** — chat panel + inline edit workflows via configurable adapters (primarily local Ollama models)

Both suggestion providers **start disabled** at nvim startup. Toggle on demand via `<leader>a*`. Statusline shows current state.

## Files

| Path | Role |
|---|---|
| `lua/config/plugins/copilot.lua` | Copilot plugin spec + `<leader>ap` toggle + startup disable |
| `lua/config/plugins/windsurf.lua` | Windsurf/Codeium spec + `<leader>aw` toggle + startup disable |
| `lua/config/plugins/codecompanion.lua` | CodeCompanion chat + inline adapter config (Ollama-heavy) |
| `lua/config/utils/ai_toggle.lua` | Centralized state, per-provider actions, combined toggle, statusline component |
| `lua/config/plugins/lualine.lua` | Wires `ai_toggle.statusline()` into `lualine_x` |
| `lua/config/utils/keymap_desc.lua` | `T.Copilot`, `T.Windsurf`, `T.AI` enum entries |

## Keymaps

| Key | Action |
|---|---|
| `<leader>ac` | Toggle CodeCompanion chat panel |
| `<leader>aa` | CodeCompanion actions palette |
| `<leader>ap` | Toggle Copilot on/off (global) |
| `<leader>aw` | Toggle Windsurf on/off (global) |
| `<leader>aA` | Combined toggle — enable both if all off, disable both if any on |

## Statusline

Right side of lualine, before encoding. States:

| Display | Meaning |
|---|---|
| `AI C+W` | Both providers active (`String` hl — green in most themes) |
| `AI C` | Copilot only |
| `AI W` | Windsurf only |
| `AI off` | Both disabled (`Comment` hl — dim) |

## Startup defaults

Both Copilot and Windsurf start **disabled**. Reasons:

- No network chatter or API usage when nvim opens
- Explicit opt-in — decide per session when you want AI
- No surprise costs on subscription plans

To change: remove the trailing `vim.schedule(...)` disable block in `copilot.lua` / `windsurf.lua`. Silent-disable helper lives at `ai_toggle.startup_disable_all()`.

## Setup requirements

### Copilot

- `node` v20+ on PATH
- Sign in once via `:Copilot auth`
- GitHub Copilot subscription

### Windsurf / Codeium

- Free tier — no subscription
- Authenticate via `:Codeium Auth` (opens browser once)

### CodeCompanion

- Ollama running locally on `:11434` (default)
- Adapters + models configured inline — see `lua/config/plugins/codecompanion.lua`

## Adding a new AI provider

Follow the Copilot / Windsurf pattern:

1. Add plugin file under `lua/config/plugins/<provider>.lua`.
2. Extend `ai_toggle.lua`:
   - `is_<provider>_enabled()`
   - `enable_<provider>({silent})` / `disable_<provider>({silent})`
   - `toggle_<provider>()`
   - Update `toggle_all()` and `statusline()` to include it.
3. Add `T.<Provider>` to `lua/config/utils/keymap_desc.lua`.
4. Wire a `<leader>a<key>` toggle in the plugin file.
5. Add rows to the Keymaps and Setup tables in this doc.

## Related

- Local AI completion via `minuet-ai.nvim` + Ollama — planned; see `.plan/chore-nvim-improvements/PLAN.md` section 1.
- [completion.md](completion.md) — blink.cmp source stack; AI providers register here as sources.
- [keymaps.md](keymaps.md) — full keymap reference.
