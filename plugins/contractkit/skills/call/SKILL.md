---
name: call
description: Call functions on deployed contracts
---

# ContractKit: Call

Call functions on deployed contracts.

## Usage

```
/contractkit:call <function> [--args <arguments>] [--network <network>]
```

## Process

### 1. Determine Network

Default: `local`

Check for deployment file at `deployments/<network>.json`

### 2. Load Contract Address

Read address from `deployments/<network>.json`:
```json
{
  "Token": "0x..."
}
```

### 3. Determine Call Type

- **View/Pure functions** (read-only): Use `cast call`
- **State-changing functions**: Use `cast send`

Common view functions: `name`, `symbol`, `balanceOf`, `totalSupply`, `decimals`

### 4. Execute Call

For view functions:
```bash
cast call <address> "<function>(<types>)" <args> --rpc-url <rpc>
```

For state-changing functions:
```bash
cast send <address> "<function>(<types>)" <args> --rpc-url <rpc>
```

### 5. Decode and Display Result

Parse the return value and display in human-readable format.

## Examples

### Read Token Name
```
/contractkit:call name
```
→ `cast call 0x... "name()"` → "MyToken"

### Check Balance
```
/contractkit:call balanceOf --args "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266"
```
→ `cast call 0x... "balanceOf(address)" 0xf39...`

### Mint Tokens (state-changing)
```
/contractkit:call mint --args "0xf39..." "1000000000000000000"
```
→ `cast send 0x... "mint(address,uint256)" 0xf39... 1000000000000000000`

### Check on Sepolia
```
/contractkit:call name --network sepolia
```

## Function Signatures

The skill should detect common function signatures:

| Function | Signature | Type |
|----------|-----------|------|
| `name` | `name()` | view |
| `symbol` | `symbol()` | view |
| `decimals` | `decimals()` | view |
| `totalSupply` | `totalSupply()` | view |
| `balanceOf` | `balanceOf(address)` | view |
| `mint` | `mint(address,uint256)` | write |
| `transfer` | `transfer(address,uint256)` | write |
| `approve` | `approve(address,uint256)` | write |

For unknown functions, ask the user for the full signature.

## Error Handling

- **"No deployment found"**: Run `/contractkit:deploy` first
- **"Function not found"**: Check function name and signature
- **"Wrong number of arguments"**: Verify argument count
- **"Execution reverted"**: Check access control or preconditions
