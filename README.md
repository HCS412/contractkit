# ContractKit

[![CI](https://github.com/HCS412/contractkit/actions/workflows/ci.yml/badge.svg)](https://github.com/HCS412/contractkit/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-0.1.0-blue.svg)](https://github.com/HCS412/contractkit/releases/tag/v0.1.0)

A Claude Code plugin for generating complete, production-ready smart contract projects from safe templates.

## Why ContractKit?

- **Skip the boilerplate** - Generate complete Foundry projects with one command
- **Security-first templates** - OpenZeppelin-based contracts with ReentrancyGuard, AccessControl, and threat models
- **Test coverage included** - Every template comes with comprehensive Foundry tests
- **Deploy anywhere** - Local Anvil, Sepolia testnet, or mainnet with the same workflow
- **Learn as you build** - `/explain` and `/audit-lite` commands help you understand your contracts

ContractKit enforces best-practice defaults while remaining configurable. It provides commands to scaffold projects, run tests, manage local chains, deploy contracts, interact with deployments, and produce risk reports.

## Installation

```bash
# Step 1: Add the marketplace
/plugin marketplace add HCS412/contractkit

# Step 2: Install the plugin
/plugin install contractkit@HCS412/contractkit
```

### Local Development

```bash
git clone https://github.com/HCS412/contractkit.git
cd contractkit
claude --plugin-dir ./plugins/contractkit
```

## Quickstart (60-second demo)

```bash
# 1. Install the plugin
/plugin marketplace add HCS412/contractkit
/plugin install contractkit@HCS412/contractkit

# 2. Generate an ERC20 project
/contractkit:new erc20 MyToken MTK

# 3. Run tests
cd contractkit-projects/mytoken
/contractkit:test

# 4. Start local chain
/contractkit:local

# 5. Deploy
/contractkit:deploy local

# 6. Mint tokens
/contractkit:call mint --args "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266" "1000000000000000000"

# 7. Check balance
/contractkit:call balanceOf --args "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266"
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
