# skillCreator

A workspace for developing, testing, and managing agent skills compatible with Claude Code and OpenClaw.

## Project Structure

```
skillCreator/
├── skills/           # Skill source (version controlled)
│   └── <skill-name>/
│       ├── SKILL.md  # Skill instructions (AgentSkills spec)
│       └── *.py      # Supporting scripts
├── scripts/
│   └── install.sh    # Install skills to ~/.claude/skills/
└── templates/
    └── SKILL_TEMPLATE.md
```

## Skill Format

All skills follow the AgentSkills spec — compatible with both Claude Code and OpenClaw.

Frontmatter fields:
- `name`: skill identifier (kebab-case)
- `description`: one-line description (used for trigger matching)
- `trigger`: Claude Code trigger conditions
- `user-invocable`: true (OpenClaw slash command)
- `metadata.openclaw.requires`: env vars required
- `metadata.openclaw.install`: dependency install method

## Installing Skills

```bash
./scripts/install.sh             # Install all skills
./scripts/install.sh x-search   # Install specific skill
```

Skills are symlinked to `~/.claude/skills/<name>/`.

## Developing a New Skill

1. Copy `templates/SKILL_TEMPLATE.md` to `skills/<name>/SKILL.md`
2. Fill in frontmatter and instructions
3. Add supporting scripts in `skills/<name>/` if needed
4. Run `./scripts/install.sh <name>` to install
5. Test in a new Claude Code conversation

## Development Guidelines

Principles learned from building skills. Apply to all new skills.

### SKILL.md
- Keep SKILL.md focused on agent instructions and core usage only
- Move extended docs (scheduling, advanced config) to separate files (e.g., `OPENCLAW.md`)
- SKILL.md is loaded into context on every trigger — size matters
- For skills that return large outputs, add a **Context efficiency** section instructing the agent to show a brief summary and only display full content when explicitly requested

### Scripts
- Use env vars for all API keys — never hardcode credentials
- For model/version selection: use a stable alias as default + an env var override (e.g., `MODEL = os.environ.get("XAI_MODEL", "grok-4")`) so users can pin versions without editing code
- `stdout` for output data, `stderr` for status messages and warnings — Claude reads stdout; stderr is for the user/operator
- Set `timeout=120` for LLM API calls (60s is often not enough)
- Always check for empty API responses explicitly; never silently return blank output
- File I/O: use `try/except` directly — do not pre-check with `os.path.exists()` (TOCTOU anti-pattern)

### File Output Pattern (`--output` flag)
- Accept both a directory (auto-name the file) and a full path
- Auto-name with date stamp: `<stem>-YYYY-MM-DD.md`
- If file already exists, add HHmm suffix to avoid silent overwrite: `<stem>-YYYY-MM-DD-HHmm.md`
- Use `_sanitize()` to make filenames safe (strip `@#`, spaces → hyphens, truncate)

### Structured Output Parsing (LLM → structured text)
- Use a unique separator between records (e.g., `---RECORD_SEPARATOR---`) so splitting is unambiguous
- Use a state machine parser for multiline field values — simple line-by-line matching drops continuation lines
- Validate parsed records before rendering: skip entries missing required fields

### Separation of Concerns (config-driven skills)
- YAML config: **what** to monitor (subjects only — accounts, topics, keywords)
- CLI args: **how** to query (time range, language, output path, filters)
- OpenClaw cron / scheduler: **when** to run
- Never mix these three. Putting query params in YAML creates duplication and confusion.

## Backlog

- [ ] GitHub project analysis skill (provide repo name → product/project analysis report)
