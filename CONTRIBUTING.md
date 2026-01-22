# Contributing to ContractKit

Thank you for your interest in contributing! This guide covers how to set up your development environment, add new templates, and submit changes.

## Development Setup

### Prerequisites

1. **Foundry**: Install from [getfoundry.sh](https://book.getfoundry.sh/getting-started/installation)
   ```bash
   curl -L https://foundry.paradigm.xyz | bash
   foundryup
   ```

2. **Claude Code**: Required to test skills locally

3. **Python 3.8+**: For deployment parsing scripts

### Local Development

```bash
# Clone the repo
git clone https://github.com/your-org/contractkit.git
cd contractkit

# Validate all templates compile and pass tests
./tools/validate_templates.sh

# Run the smoke test (end-to-end)
./tools/smoke_test.sh
```

## Adding a New Template

Templates live in `plugins/contractkit/templates/<blueprint-name>/`.

### Template Structure

```
templates/your-template/
  foundry.toml
  remappings.txt
  src/
    YourContract.sol
  test/
    YourContract.t.sol
  script/
    Deploy.s.sol
    Interact.s.sol      # optional
  README.md
  SECURITY.md
  THREAT_MODEL.md
  .env.example
  deployments/
    .gitkeep
```

### Placeholder Conventions

Use these placeholders in your template files:

| Placeholder | Replaced With |
|-------------|---------------|
| `{{PROJECT_NAME}}` | Project name (e.g., "MyToken") |
| `{{PROJECT_SLUG}}` | Lowercase slug (e.g., "mytoken") |
| `{{TOKEN_NAME}}` | Token name for ERC20/721 |
| `{{TOKEN_SYMBOL}}` | Token symbol |
| `{{ADMIN_MODEL}}` | "owner" or "accesscontrol" |

### Requirements

Every template must:

1. **Compile**: `forge build` succeeds
2. **Pass tests**: `forge test` passes
3. **Format**: `forge fmt --check` passes
4. **Deploy locally**: `Deploy.s.sol` works on Anvil
5. **Document risks**: Include `THREAT_MODEL.md`

### Solidity Style

- Pragma: `pragma solidity ^0.8.20;`
- Use OpenZeppelin contracts (pinned version)
- Follow [Solidity Style Guide](https://docs.soliditylang.org/en/latest/style-guide.html)
- Run `forge fmt` before committing

## Adding a New Skill

Skills live in `plugins/contractkit/skills/<skill-name>/SKILL.md`.

### Skill Guidelines

- Be explicit and deterministic
- Provide clear error messages
- Include usage examples in the skill file
- Test with Claude Code locally

## Pull Request Process

1. **Fork and branch**: Create a feature branch from `main`
2. **Make changes**: Follow the guidelines above
3. **Validate**: Run `./tools/validate_templates.sh`
4. **Test**: Run `./tools/smoke_test.sh`
5. **Document**: Update relevant docs if needed
6. **Submit PR**: Fill out the PR template

### PR Requirements

- [ ] All templates compile and tests pass
- [ ] `forge fmt --check` passes
- [ ] Documentation updated (if applicable)
- [ ] CHANGELOG.md updated
- [ ] No secrets or keys committed

## Code Review

PRs require one approval before merging. Reviewers check for:

- Security implications
- Code quality and style
- Test coverage
- Documentation completeness

## Questions?

Open an issue for questions or discussion about potential contributions.
