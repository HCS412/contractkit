# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2026-01-22

### Added

- Initial release of ContractKit Claude Code plugin
- **4 Blueprint Templates:**
  - ERC20: Fungible token with role-based minting (AccessControl)
  - ERC721: NFT collection with role-based minting and metadata
  - Escrow: Three-party escrow with release/refund/dispute resolution
  - Vault: ETH deposit/withdraw with pause functionality
- **8 Skills/Commands:**
  - `/contractkit:new` - Scaffold new projects from templates
  - `/contractkit:test` - Run Foundry test suites
  - `/contractkit:local` - Start local Anvil node
  - `/contractkit:deploy` - Deploy to local or Sepolia
  - `/contractkit:call` - Interact with deployed contracts
  - `/contractkit:status` - Check project and deployment status
  - `/contractkit:explain` - Explain contract code
  - `/contractkit:audit-lite` - Quick security review (not an audit)
- **Security:**
  - OpenZeppelin-based implementations (ERC20, ERC721, AccessControl, ReentrancyGuard)
  - SECURITY.md and THREAT_MODEL.md for each template
  - Security disclaimer and best practices documentation
- **Testing & CI:**
  - Comprehensive Foundry test suites for all templates
  - Template validation script
  - End-to-end smoke test
  - GitHub Actions CI/CD workflows
- **Documentation:**
  - Plugin usage guide
  - Template guidelines
  - Architecture documentation
  - Contributing guidelines
