# ContractKit

A Claude Code plugin for generating complete, production-ready smart contract projects from safe templates.

ContractKit enforces best-practice defaults while remaining configurable. It provides commands to scaffold projects, run tests, manage local chains, deploy contracts, interact with deployments, and produce risk reports.

## Installation

### Option A: Install from GitHub (recommended)

```bash
claude /plugin install https://github.com/HCS412/contractkit
```

### Option B: Add as marketplace source

```bash
# Add the marketplace source
claude /plugin marketplace add HCS412/contractkit

# Then install
claude /plugin install contractkit
```

### Local Development

For plugin development and testing:

```bash
git clone https://github.com/HCS412/contractkit.git
cd contractkit
claude --plugin-dir ./plugins/contractkit
```

## Quickstart (60-second demo)

```bash
# 1. Install the plugin (if not already installed)
claude /plugin install https://github.com/HCS412/contractkit

# 2. Generate an ERC20 project
claude /contractkit:new --blueprint erc20 --name "MyToken" --symbol "MTK"

# 3. Run tests
cd contractkit-projects/mytoken
claude /contractkit:test

# 4. Start local chain and deploy
claude /contractkit:local
claude /contractkit:deploy local

# 5. Interact with your contract
claude /contractkit:call balanceOf --args "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266"
```

## Supported Blueprints

| Blueprint | Description |
|-----------|-------------|
| `erc20`   | Fungible token with role-based minting (AccessControl) |
| `erc721`  | NFT with role-based minting and base URI |
| `escrow`  | Three-party escrow with release/refund/dispute |
| `vault`   | Deposit/withdraw vault with reentrancy protection |

## Commands

| Command | Description |
|---------|-------------|
| `/contractkit:new` | Scaffold a new project from a template |
| `/contractkit:test` | Format and run tests |
| `/contractkit:local` | Start local Anvil chain |
| `/contractkit:deploy <network>` | Deploy to local or Sepolia |
| `/contractkit:call <fn>` | Call contract functions |
| `/contractkit:status` | Show project status and deployments |
| `/contractkit:explain` | Explain what a contract does |
| `/contractkit:audit-lite` | Generate a risk report (not an audit) |

## How Templates Work

Templates are complete Foundry projects with placeholders:

1. `/contractkit:new` copies the template to your project directory
2. Placeholders like `{{TOKEN_NAME}}` are replaced with your values
3. `forge fmt` and `forge test` run automatically
4. You get a working, tested project ready for customization

## Security Disclaimer

**This is not an audit.** ContractKit generates starter templates with reasonable defaults, but:

- All contracts must be reviewed by qualified auditors before mainnet deployment
- Templates are educational starting points, not production-ready code
- You are responsible for understanding and securing your contracts
- Never deploy to mainnet without independent security review

See [SECURITY.md](SECURITY.md) and [DISCLAIMER.md](DISCLAIMER.md) for full details.

## Requirements

- [Foundry](https://book.getfoundry.sh/getting-started/installation) (forge, anvil, cast)
- [Claude Code](https://claude.ai/code)

## Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for:

- How to add new template blueprints
- Development setup
- Style guidelines
- PR requirements

## License

MIT License. See [LICENSE](LICENSE).
