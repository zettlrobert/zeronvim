# AI

## TLDR

Three AI tools. Copilot and Minuet start disabled; toggle them with `<leader>a*`. The statusline shows which are on.

| Tool | Kind | Backend | When to use |
|---|---|---|---|
| **Copilot** | Inline suggestions + blink source | GitHub cloud | General completion (subscription) |
| **Minuet** | Blink completion source | Local Ollama (FIM) | Offline, private completion |
| **CodeCompanion** | Chat + inline edit | Local OpenAI-compatible server (default) or Ollama | Multi-turn work, explain, refactor |

## Files

| Path | Role |
|---|---|
| `lua/config/plugins/copilot.lua` | Copilot spec (lazy; loads on first enable or `:Copilot`), defaults itself off |
| `lua/config/plugins/minuet-ai.lua` | Minuet spec (lazy), Ollama backend, defaults itself off |
| `lua/config/plugins/completion.lua` | Blink sources; `copilot`/`minuet` are listed only while enabled |
| `lua/config/plugins/codecompanion.lua` | CodeCompanion adapters, mcphub extension |
| `lua/config/utils/ai_toggle.lua` | Provider table, enable/disable/toggle, `toggle_all()`, statusline component |
| `lua/config/plugins/lualine.lua` | Puts `ai_toggle.statusline()` in `lualine_x` |
| `lua/config/keymaps.lua` | `<leader>a*` keymaps |

## Keymaps

| Key | Action |
|---|---|
| `<leader>ac` | Toggle CodeCompanion chat |
| `<leader>aa` | CodeCompanion actions palette |
| `<leader>ap` | Toggle Copilot (global) |
| `<leader>am` | Toggle Minuet |
| `<leader>aA` | Any provider on: disable all. All off: enable all |

Copilot's own suggestion keys (insert mode): `<M-l>` accept, `<M-]>`/`<M-[>` next/previous, `<C-]>` dismiss.
`auto_trigger` is off.

## Statusline

Right side of lualine, between the LSP client count and the encoding.

| Display | Meaning |
|---|---|
| `AI <icon> Copilot <icon> Minuet` | Both on, each in its own color (`MiniIconsGreen` / `MiniIconsYellow`) |
| `AI <icon> Copilot` | One on |
| `AI off` | All off (dim, `Comment` highlight) |

Glyphs come from `icons.AI` in `lua/config/assets/icons.lua`. mini-icons and blink's `kind_icons` use the same glyphs
and highlights.

## Startup defaults

Copilot and Minuet start disabled:

- No network traffic to Copilot when nvim opens.
- No Ollama inference until you ask for it.
- You opt in per session.

Both plugins are lazy and load on first enable. Each plugin's `config` also schedules
`ai_toggle.disable_<provider>({ silent = true })`, so other load paths (`:checkhealth`, a `require`) start off too. `ai_toggle` queues its enable after
that disable, so an explicit enable wins.

To make a provider always on: remove that scheduled disable and give the spec `event = "InsertEnter"`.

## Setup requirements

### Copilot

- `node` v20+ on `PATH`.
- A GitHub Copilot subscription.
- Sign in once: `:Copilot auth`.

The plugin is pinned to `^3.2`, which downloads the native `copilot-language-server` on first use. Older tags fail with
"could not find server (bad install?)".

### Minuet (local completion via Ollama)

1. Install [Ollama](https://ollama.com/) and run it on `:11434`.
2. Pull the model: `ollama pull qwen2.5-coder:7b-base` (~4.7GB).
3. Verify: `curl http://localhost:11434/api/tags | grep qwen2.5-coder`.

Use the `-base` tag, not plain `:7b`. The default tag is the instruct (chat) variant. It handles FIM tokens loosely, so
completions overlap or shift by one character.

First use:

1. `<leader>am` (or `<leader>aA`).
2. Type in a code file. Minuet items appear in the blink menu next to LSP and buffer items.
3. `<C-Space>` opens the menu if it does not appear.

Requests are paced by `throttle = 1500` and `debounce = 400` (ms). The blink source times out after 3000 ms.

### CodeCompanion

- Default adapter for chat, inline, cmd and background: `qwen/qwen3.6-35b-a3b`, an `openai_compatible` adapter at
  `http://localhost:1234`.
- The other adapters (`gpt-oss`, `devstral`, `qwen3:32b` and more) extend `ollama` and need Ollama on `:11434`.
- MCP tools come from mcphub (`:MCPHub`, `~/.config/mcphub/servers.json`).

## Switching Minuet backends

Minuet points at local Ollama. To change the backend, edit `provider_options` in `lua/config/plugins/minuet-ai.lua`:

```lua
provider = "openai_fim_compatible",
provider_options = {
  openai_fim_compatible = {
    api_key = "TERM", -- name of an env var; TERM always exists, so no auth leaks
    name = "Fenrir", -- display name in the completion menu
    end_point = "http://fenrir.internal:8080/v1/completions",
    model = "some-code-model",
    stream = true,
  },
},
```

When Fenrir gets an OpenAI-compatible endpoint:

1. Update `end_point` and `model`.
2. Register several `provider_options` and switch at runtime with `:Minuet change_provider <name>`.
3. Optionally add a `<leader>aB` backend picker.

Ollama models for FIM:

| Model | Size | GPU | CPU | Quality |
|---|---|---|---|---|
| `qwen2.5-coder:1.5b` | ~1GB | Very fast | Fast | Good |
| `qwen2.5-coder:3b` | ~2GB | Very fast | Fast | Better |
| `qwen2.5-coder:7b-base` (default) | ~4.7GB | Fast | Usable | Best local FIM option |
| `qwen2.5-coder:14b` | ~9GB | Medium | Slow | Needs 12GB+ VRAM |
| `codellama:7b` | ~3.8GB | Fast | Usable | Meta's coding model |
| `deepseek-coder-v2:16b` | ~9GB | Medium | Slow | Strong on Python/JS |

Measured on an RX 7900 XTX (2026-11), 15 simulated keystrokes in a large Lua file:

| Setup | Time to first token | Notes |
|---|---|---|
| Ollama, `7b-base`, `context_window = 12000` | ~1.1 s | Current setup; 2,944 prompt tokens |
| llama-server, same GGUF | ~0.9 s | Not worth a second always-loaded server |
| Ollama, `qwen3-coder:30b` | ~1.5 s, 2.9 s total | Instruct only: never stops, invents code; unsuitable for FIM |
| First request after 5 min idle | +4 s | Ollama reloads the model; `OLLAMA_KEEP_ALIVE` raises the timeout |

Prompt caching barely helps: once a file exceeds the window, minuet trims the front of the prompt on every request, so
neither runtime can reuse its KV cache.

## Adding a new AI provider

1. Add the plugin spec at `lua/config/plugins/<provider>.lua`: `lazy = true`, and schedule
   `ai_toggle.set("<provider>", false, { silent = true })` at the end of `config`.
2. In `lua/config/utils/ai_toggle.lua`: add an entry to `PROVIDERS` (`plugin`, `name`, `icon`, `hl`, `get`, `set`), add
   it to `ORDER`, and add the named wrappers (`toggle_<provider>` and so on) if keymaps need them.
3. Add the glyph to `icons.AI` in `lua/config/assets/icons.lua`, and `<Provider>` to `TOOL` in
   `lua/config/utils/keymap_desc.lua`.
4. Add a `<leader>a<key>` keymap in `lua/config/keymaps.lua`.
5. For a blink source: add it to `sources.providers` in `completion.lua`, and insert it in the `sources.default`
   function behind an `is_enabled` check.
6. Update the tables in this doc.

## Related

- [completion.md](completion.md) - blink.cmp sources; Copilot and Minuet register here.
- [keymaps.md](keymaps.md) - full keymap reference.
- `.plan/chore-nvim-improvements/PLAN.md` section 1 - Fenrir backend status.
