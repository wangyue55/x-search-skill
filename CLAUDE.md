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

## Backlog

- [ ] GitHub project analysis skill (provide repo name → product/project analysis report)
