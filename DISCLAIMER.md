# Disclaimer

## Not Financial Advice

ContractKit is a development tool. Nothing in this project constitutes financial advice. Do not make investment decisions based on template code or documentation.

## Not Legal Advice

This project does not provide legal advice. Smart contracts may have legal implications depending on your jurisdiction. Consult qualified legal counsel before deploying contracts that handle value.

## Not an Audit

ContractKit templates have **not been audited** by professional security auditors. The `/contractkit:audit-lite` command generates a risk checklist based on common patterns—it is **not** a substitute for professional security review.

Before deploying any contract to mainnet:

1. Understand every line of code
2. Have the contract reviewed by qualified auditors
3. Consider formal verification for high-value contracts
4. Test extensively on testnets
5. Implement monitoring and incident response plans

## Your Responsibility

You are solely responsible for:

- **Key security**: Private keys never leave your machine, but you must secure your environment
- **Contract review**: Understand what you're deploying
- **Deployment decisions**: We don't control where you deploy
- **Funds at risk**: Any funds in your contracts are your responsibility
- **Regulatory compliance**: Ensure your use case complies with applicable laws

## Environment Security

ContractKit scripts:

- Never transmit private keys over the network (except to your specified RPC)
- Never phone home or collect telemetry
- Only interact with endpoints you explicitly configure

However, you must ensure:

- Your `.env` files are in `.gitignore`
- You don't commit secrets to version control
- Your local machine is secure
- You use hardware wallets or secure key management for mainnet

## No Warranty

This software is provided "as is" without warranty of any kind. See [LICENSE](LICENSE) for full terms.

## Template Limitations

Templates are educational starting points. They may not be suitable for:

- High-value applications without modification
- Complex DeFi protocols
- Cross-chain applications
- MEV-sensitive operations
- Regulatory-compliant token offerings

## Acknowledgment

By using ContractKit, you acknowledge that you have read and understood this disclaimer and accept full responsibility for your use of the generated code.
