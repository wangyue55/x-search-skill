---
name: skill-name
description: One-line description of what this skill does (used for trigger matching).
trigger: Use when user wants to... Triggers include "keyword1", "keyword2", "中文触发词".
user-invocable: true
metadata:
  openclaw:
    requires:
      - ENV_VAR_NAME
    install:
      pip: package-name
---

# Skill Name

Brief description of the skill.

## Invocation

### Slash Command
```
/skill-name <args>
```

### Natural Language
- "..."
- "..."

## Workflow

Step-by-step instructions for the agent.

### Step 1: Parse intent

...

### Step 2: Execute

```bash
python {SKILL_DIR}/script.py <args>
```

### Step 3: Present output

...

## Output Format

Describe the expected output format.

## Error Handling

- **Missing env var**: tell the user to set `export ENV_VAR=...`
- **No results**: ...
