# Architecture

How ContractKit is structured and operates.

## Overview

```
contractkit/
├── plugins/contractkit/     # The plugin package
│   ├── .claude-plugin/      # Plugin manifest
│   ├── skills/              # Claude Code skills
│   ├── templates/           # Contract templates
│   ├── scripts/             # Helper scripts
│   └── docs/                # Documentation
├── tools/                   # Validation tooling
├── examples/                # Example projects
└── .claude/skills/          # Dev symlinks
```

## Component Responsibilities

### Skills (plugins/contractkit/skills/)

Skills are Claude Code instructions that guide the AI through workflows.

| Skill | Responsibility |
|-------|----------------|
| new | Scaffold projects from templates |
| test | Format and test code |
| local | Start local blockchain |
| deploy | Deploy to networks |
| call | Interact with contracts |
| explain | Document contracts |
| audit-lite | Generate risk reports |

Skills are declarative—they describe what to do, not how to implement it.

### Templates (plugins/contractkit/templates/)

Pre-built Foundry projects with placeholder values.

Each template is self-contained:
- Compiles independently
- Tests pass
- Deploys to local chain
- Documents risks

Templates use placeholders (`{{TOKEN_NAME}}`) that skills replace during scaffolding.

### Scripts (plugins/contractkit/scripts/)

Small, auditable shell/Python scripts for common operations.

Design principles:
- Single responsibility
- No external dependencies
- No network calls beyond RPC
- Human-readable

### Tools (tools/)

CI/validation tooling:
- `validate_templates.sh` - Ensure templates compile and test
- `smoke_test.sh` - End-to-end verification

## Data Flow

### Project Scaffolding

```
User → /new skill → Copy template → Replace placeholders → Install deps → Run tests → Project
```

### Deployment

```
User → /deploy skill → forge script → RPC endpoint → Blockchain
                    ↓
            parse_deployments.py → deployments/<network>.json
```

### Contract Interaction

```
User → /call skill → Load deployment → cast call/send → RPC → Blockchain
```

## State Management

ContractKit stores minimal state:

| Location | Content |
|----------|---------|
| `deployments/<network>.json` | Contract addresses |
| `broadcast/` | Forge deployment logs |
| `.env` | User configuration |

No remote state. Everything is local and version-controllable.

## Design Principles

1. **Deterministic**: Same inputs produce same outputs
2. **Auditable**: Small, readable scripts
3. **Local-first**: No cloud dependencies
4. **Non-destructive**: Don't delete user data
5. **Explicit**: No hidden behavior
6. **Composable**: Skills work independently
