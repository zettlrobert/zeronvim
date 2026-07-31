# AI

## TLDR

Four complementary AI tools, all toggleable and default-off:

| Tool | Kind | Backend | When to use |
|---|---|---|---|
| **Copilot** | Suggestions + completion | GitHub cloud | High-quality general completion (subscription) |
| **Windsurf / Codeium** | Suggestions + completion | Codeium cloud | Free-tier completion fallback |
| **Minuet** | Completion (blink source) | Local Ollama | Offline, privacy-preserving completion |
| **CodeCompanion** | Chat + inline edit | Local Ollama adapters | Multi-turn work, explain, refactor |

All three suggestion providers **start disabled** at nvim startup. Toggle on demand via `<leader>a*`. Statusline shows current state.

## Files

| Path | Role |
|---|---|
| `lua/config/plugins/copilot.lua` | Copilot spec + `<leader>ap` toggle + startup disable |
| `lua/config/plugins/windsurf.lua` | Windsurf/Codeium spec + `<leader>aw` toggle + startup disable |
| `lua/config/plugins/minuet-ai.lua` | Minuet spec + Ollama backend config + `<leader>am` toggle + startup disable |
| `lua/config/plugins/completion.lua` | Blink source registration for all AI providers |
| `lua/config/plugins/codecompanion.lua` | CodeCompanion chat + inline adapter config (Ollama-heavy) |
| `lua/config/utils/ai_toggle.lua` | Centralized state, per-provider actions, combined toggle, statusline component |
| `lua/config/plugins/lualine.lua` | Wires `ai_toggle.statusline()` into `lualine_x` |
| `lua/config/utils/keymap_desc.lua` | `T.Copilot`, `T.Windsurf`, `T.Minuet`, `T.AI` enum entries |

## Keymaps

| Key | Action |
|---|---|
| `<leader>ac` | Toggle CodeCompanion chat panel |
| `<leader>aa` | CodeCompanion actions palette |
| `<leader>ap` | Toggle Copilot on/off (global) |
| `<leader>aw` | Toggle Windsurf on/off (global) |
| `<leader>am` | Toggle Minuet (local AI completion) on/off |
| `<leader>aA` | Combined toggle — enable all if any off, disable all if any on |

## Statusline

Right side of lualine, before encoding.

| Display | Meaning |
|---|---|
| `AI C+W+M` | All three providers active (`String` hl — green) |
| `AI C+W` / `AI C+M` / `AI W+M` | Two active |
| `AI C` / `AI W` / `AI M` | One active |
| `AI off` | All disabled (`Comment` hl — dim) |

## Startup defaults

All three completion providers start **disabled**. Reasons:

- No network chatter (Copilot / Windsurf) when nvim opens
- No spinning up Ollama inference (Minuet) unless requested
- Explicit opt-in — decide per session which providers you want
- No surprise API costs on subscription plans

Each plugin's config file calls `ai_toggle.disable_<provider>({silent = true})` via `vim.schedule` after setup. To restore always-on for one provider, remove that block from its plugin file. To disable one at startup and keep others on, invert the pattern.

## Setup requirements

### Copilot

- `node` v20+ on PATH
- Sign in once via `:Copilot auth`
- GitHub Copilot subscription

### Windsurf / Codeium

- Free tier — no subscription
- Authenticate via `:Codeium Auth` (opens browser once)

### Minuet (local AI completion via Ollama)

**Prerequisites:**

- [Ollama](https://ollama.com/) installed and running on `:11434`
- Model pulled: `ollama pull qwen2.5-coder:7b` (~4.7GB)

**Verify:**

```bash
curl http://localhost:11434/api/tags | grep qwen2.5-coder
```

**First use:**

1. `<leader>am` (or `<leader>aA`) to enable
2. Start typing in a code file — completions appear in the blink menu alongside LSP/buffer suggestions
3. `<C-Space>` to force-open the completion menu if it doesn't auto-appear

Backend config lives in `lua/config/plugins/minuet-ai.lua`. See "Switching Minuet backends" below.

### CodeCompanion

- Ollama running locally on `:11434` (default)
- Adapters + models configured inline — see `lua/config/plugins/codecompanion.lua`

## Switching Minuet backends

Minuet currently points at local Ollama. To swap or add a backend (e.g., when Fenrir goes public), edit `lua/config/plugins/minuet-ai.lua`:

```lua
require("minuet").setup({
  provider = "openai_fim_compatible",  -- for FIM endpoints (Ollama, Fenrir if compat)
  provider_options = {
    openai_fim_compatible = {
      api_key = "TERM",                 -- or a real env var if the backend needs auth
      name = "Fenrir",                  -- display name in the completion menu
      end_point = "http://fenrir.internal:8080/v1/completions",
      model = "some-code-model",
      stream = true,
    },
  },
})
```

**When Fenrir gets an OpenAI-compatible endpoint:**

1. Update `end_point` + `model`
2. Add fallback support by registering multiple `provider_options` — minuet allows switching at runtime via `:Minuet change_provider <name>`
3. Consider adding `<leader>aB` picker via `Snacks.picker` for runtime backend selection

**Model recommendations for Ollama:**

| Model | Size | Speed on GPU | Speed on CPU | Quality |
|---|---|---|---|---|
| `qwen2.5-coder:1.5b` | ~1GB | Very fast | Fast | Good |
| `qwen2.5-coder:3b` | ~2GB | Very fast | Fast | Better |
| `qwen2.5-coder:7b` (default) | ~4.7GB | Fast | Usable | Best local option |
| `qwen2.5-coder:14b` | ~9GB | Medium | Slow | Best local, needs 12GB+ VRAM |
| `codellama:7b` | ~3.8GB | Fast | Usable | Meta's coding model |
| `deepseek-coder-v2:16b` | ~9GB | Medium | Slow | Strong on Python/JS |

## Adding a new AI provider

Follow the Copilot / Windsurf / Minuet pattern:

1. Add plugin file under `lua/config/plugins/<provider>.lua`.
2. Extend `ai_toggle.lua`:
   - `is_<provider>_enabled()`
   - `enable_<provider>({silent})` / `disable_<provider>({silent})`
   - `toggle_<provider>()`
   - Update `toggle_all()`, `startup_disable_all()`, and `statusline()`.
3. Add `T.<Provider>` to `lua/config/utils/keymap_desc.lua`.
4. Wire a `<leader>a<key>` toggle in the plugin file.
5. If it's a blink source, register in `completion.lua` (both `sources.default` and `providers`).
6. Add rows to the Keymaps and Setup tables in this doc.

## Related

- [completion.md](completion.md) — blink.cmp source stack; AI providers register here as sources.
- [keymaps.md](keymaps.md) — full keymap reference.
- `.plan/chore-nvim-improvements/PLAN.md` section 1 — Fenrir backend integration status.
