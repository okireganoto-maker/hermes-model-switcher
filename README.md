# Hermes Model Switcher

![macOS](https://img.shields.io/badge/macOS-13%2B-blue?logo=apple&logoColor=white)
![bash](https://img.shields.io/badge/bash-5%2B-4EAA25?logo=gnubash&logoColor=white)
![license](https://img.shields.io/badge/license-MIT-green)

**Interactive model switcher for [Hermes AI Agent](https://herm.es) — change primary & fallback models from a desktop app, no config file editing needed.**

<!-- Add screenshot here -->

---

## Features

- **17 models preloaded** — paid providers and free models via OpenRouter, ready to select
- **Change primary model** with one keystroke — no YAML editing
- **Manage fallback chain** — add, remove, and reorder fallback providers in order of priority
- **Manage API keys** — update OpenRouter, DeepSeek, or any custom provider key; stored securely in `~/.hermes/.env`
- **Auto-restarts Hermes gateway** after every change so the new model takes effect immediately
- **Desktop .app shortcut** — double-click to launch from your Desktop, no Terminal required
- **Rate limit warnings** for free models (OpenRouter free tier: 200 req/day)

---

## Requirements

- macOS 13 or later
- [Hermes Agent](https://herm.es) installed at `~/.local/bin/hermes`
- bash 5+ (pre-installed on macOS via Homebrew or system default)

---

## Installation

```bash
git clone https://github.com/okireganoto/hermes-model-switcher
cd hermes-model-switcher
bash install.sh
```

The installer will:
1. Check for Hermes at `~/.local/bin/hermes` and warn if not found
2. Copy `hermes-model` to `/usr/local/bin/` (requires sudo)
3. Copy `Hermes Model Switcher.app` to `~/Desktop/`
4. Run a smoke test (`--dry-run`) to confirm everything works

---

## Usage

### From Terminal

```bash
hermes-model
```

### From Desktop

Double-click **Hermes Model Switcher** on your Desktop — it opens a Terminal window and launches the menu automatically.

### Menu overview

```
── Main Menu ─────────────────────────────────
  1) Change PRIMARY model
  2) Manage FALLBACK models
  3) Manage API Keys
  4) Show current config
  5) Exit
```

<!-- Add menu screenshot here -->

#### Change Primary Model

Pick from the numbered list. You'll be shown your current config, warned if you select a free-tier model, and asked to confirm before the change is written and the gateway restarted.

#### Manage Fallback Models

Hermes will try each fallback in order when the primary provider is unavailable (rate limit, overload, timeout). You can:
- **Add** — pick any model from the same list
- **Remove** — by position number
- **Swap** — reorder two entries
- **Clear** — remove all fallbacks

#### Manage API Keys

Keys are written to `~/.hermes/.env` and masked on display (`sk-or-****xxxx`). Supported:
- `OPENROUTER_API_KEY`
- `DEEPSEEK_API_KEY`
- Any custom variable name

---

## Supported Models

| # | Provider | Model ID | Tier | Context | Notes |
|---|----------|----------|------|---------|-------|
| 1 | openrouter | `deepseek/deepseek-v4-flash` | Paid | — | Recommended default |
| 2 | openrouter | `deepseek/deepseek-chat` | Paid | — | |
| 3 | deepseek | `deepseek-v4-flash` | Paid | — | Direct API |
| 4 | deepseek | `deepseek-chat` | Paid | — | Direct API |
| 5 | openrouter | `google/gemma-4-31b-it:free` | Free | 262K | Vision + Tools |
| 6 | openrouter | `nvidia/nemotron-3-super-120b-a12b:free` | Free | 1M | Tools |
| 7 | openrouter | `openai/gpt-oss-120b:free` | Free | 131K | Tools |
| 8 | openrouter | `qwen/qwen3-coder:free` | Free | 1M | Best coding |
| 9 | openrouter | `openai/gpt-oss-20b:free` | Free | 131K | Tools |
| 10 | openrouter | `z-ai/glm-4.5-air:free` | Free | 131K | Tools |
| 11 | openrouter | `qwen/qwen3-next-80b-a3b-instruct:free` | Free | 262K | |
| 12 | openrouter | `meta-llama/llama-3.3-70b-instruct:free` | Free | 131K | |
| 13 | openrouter | `moonshotai/kimi-k2.6:free` | Free | 262K | Vision |
| 14 | openrouter | `nvidia/nemotron-3-ultra-550b-a55b:free` | Free | 1M | |
| 15 | openrouter | `nousresearch/hermes-3-llama-3.1-405b:free` | Free | 131K | |
| 16 | openrouter | `openrouter/owl-alpha` | Free | 1M | OpenRouter native |
| 17 | custom | *(user input)* | Any | Any | Manual entry |

> **Free tier note:** OpenRouter free models are subject to a 200 requests/day rate limit. The tool will warn you before setting a free model as primary.

---

## How it works

`hermes-model` reads and writes `~/.hermes/config.yaml` directly using Python's built-in string processing (no `yq` or `jq` dependency). After any change it calls `hermes gateway restart` to hot-reload the config.

Config keys modified:
```yaml
model:
  provider: openrouter          # ← primary provider
  default: deepseek/deepseek-v4-flash  # ← primary model

fallback_providers:
- provider: deepseek
  model: deepseek-v4-flash
```

---

## Contributing

Pull requests welcome. To add a model, edit the `MODEL_CATALOG` array in `hermes-model`:

```bash
# Format: "provider_label|model_id|description|provider|is_free"
"openrouter|new-provider/new-model|[notes]|openrouter|0"
```

Set `is_free` to `1` to enable the 200 req/day warning for that model.

---

## License

MIT © 2026 [Oki Reganoto](https://github.com/okireganoto)
