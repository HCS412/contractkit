# Roadmap

## V1.0 (Current)

- [x] ERC20 template with AccessControl
- [x] ERC721 template with AccessControl
- [x] Escrow template (payer/payee/arbiter)
- [x] Vault template (deposit/withdraw)
- [x] `/contractkit:new` - scaffold projects
- [x] `/contractkit:test` - run tests
- [x] `/contractkit:local` - start local chain
- [x] `/contractkit:deploy` - deploy to local/Sepolia
- [x] `/contractkit:call` - interact with contracts
- [x] `/contractkit:explain` - explain contract functionality
- [x] `/contractkit:audit-lite` - generate risk checklist
- [x] Template validation CI
- [x] Documentation

## V1.1 (Planned)

- [ ] Slither integration (opt-in static analysis)
- [ ] Contract verification helper (Etherscan/Sourcify)
- [ ] Gas reporting in test output
- [ ] Additional templates: Governor, Timelock
- [ ] Improved error messages and debugging hints

## V2.0 (Future)

- [ ] MCP server for richer IDE integration
- [ ] Proxy/upgradeable contract templates (with strong warnings)
- [ ] Multi-chain support (additional testnets)
- [ ] "Diff contracts" command for upgrade migrations
- [ ] Mythril integration (opt-in formal verification)
- [ ] Template marketplace for community contributions

## Non-Goals

These are explicitly out of scope:

- Mainnet deployment automation by default
- Audit guarantees or certifications
- Advanced DeFi protocols (AMMs, lending, etc.)
- Bridge or cross-chain tooling
- Oracle integration templates
- MEV-related tooling
