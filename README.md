# x-search-skill

An agent skill for searching X (Twitter) via xAI Grok API. Compatible with **Claude Code** and **OpenClaw**.

Searches account feeds, trending topics, and topic discussions — outputs Obsidian-ready Markdown with translation, summary, and keyword explanations.

## Features

- **Account mode** — fetch posts from one or more accounts by time range or count
- **Trends mode** — top 10 posts for specified hashtags or keywords
- **Topic mode** — hot discussions around any topic
- **Multi-language output** — summaries, translations, and keyword explanations in any language (`--lang zh` by default; `--lang en` skips translation)
- **Obsidian-ready output** — structured Markdown with timestamps, original text, translation, summary, and keywords
- **File output** — auto-named with date stamps, collision-safe
- **Watchlist** — batch-run all your monitored accounts, trends, and topics from a YAML config
- **OpenClaw scheduling** — run on a cron schedule and push results to Telegram, Slack, or Discord

## Requirements

- `XAI_API_KEY` — get yours at [x.ai/api](https://x.ai/api)
- Python 3.x + `requests` (`pip install requests`)
- For watchlist: `pyyaml` (`pip install pyyaml`)

## Installation

```bash
# Clone the repo
git clone https://github.com/wangyue55/x-search-skill.git
cd x-search-skill

# Install to ~/.claude/skills/ via symlink
./scripts/install.sh x-search

# Set your API key
export XAI_API_KEY=your_key_here
```

## Usage

### Slash command (Claude Code / OpenClaw)

```
/x-search account @karpathy --time 24h
/x-search account @user1 @user2 --time 48h
/x-search --lang en account @elonmusk --count 5
/x-search trends "#AI" "#LLM"
/x-search topic "Claude MCP"
```

### CLI

```bash
# Account mode — by time range
python3 ~/.claude/skills/x-search/x_search.py account @karpathy --time 24h

# Account mode — by count, save to directory
python3 ~/.claude/skills/x-search/x_search.py --output ~/obsidian/X/ account @sama --count 10

# Trends mode
python3 ~/.claude/skills/x-search/x_search.py trends "#AI" "#LLM"

# Topic mode
python3 ~/.claude/skills/x-search/x_search.py topic "crude oil price"
```

### Watchlist

Create `~/.x-search.yaml`:

```yaml
accounts:
  - "@karpathy"
  - "@elonmusk"

trends:
  - "#AI"
  - "#LLM"

topics:
  - "Claude MCP"
  - "crude oil price"
```

Run all at once:

```bash
python3 ~/.claude/skills/x-search/watchlist.py --time 24h --lang zh --output ~/obsidian/X/
```

## Output Example

```markdown
# X Feed · @karpathy · 2026-03-22
**Scope:** last 24h · **Lang:** zh

## 1. Post · @karpathy

**Time:** 2026-03-21 14:32 UTC

**Original:**
> Scaling is not dead. It's just getting more interesting.

**Translation (zh):** 扩展规律并未终结，只是变得更加有趣。

**Summary:** Karpathy 对 AI 扩展规律的简短评论，暗示技术仍在持续演进。

**Keywords:**
- `Scaling` — 指 AI 模型随计算资源增加而性能提升的规律
```

## Project Structure

```
skills/x-search/
├── SKILL.md         # Agent instructions (Claude Code / OpenClaw)
├── x_search.py      # Core script
├── watchlist.py     # Batch runner
├── watchlist.yaml   # Sample watchlist config
└── OPENCLAW.md      # OpenClaw scheduling documentation
scripts/
└── install.sh       # Symlink installer
templates/
└── SKILL_TEMPLATE.md
```

## Scheduled Use (OpenClaw)

See [`skills/x-search/OPENCLAW.md`](skills/x-search/OPENCLAW.md) for full scheduling documentation — cron setup, delivery channels (Telegram, Slack, Discord), and job management.

## License

MIT
