#!/usr/bin/env bash
set -euo pipefail

# End-to-end smoke test for ContractKit

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
TEMPLATES_DIR="$ROOT_DIR/plugins/contractkit/templates"

echo "=== ContractKit Smoke Test ==="
echo

# Create temp directory
TMP_DIR=$(mktemp -d)
PROJECT_DIR="$TMP_DIR/smoketest"
mkdir -p "$PROJECT_DIR"

cleanup() {
    echo "Cleaning up..."
    # Kill anvil if running
    if [ -n "${ANVIL_PID:-}" ]; then
        kill "$ANVIL_PID" 2>/dev/null || true
    fi
    rm -rf "$TMP_DIR"
}
trap cleanup EXIT

echo "1. Copying ERC20 template..."
cp -r "$TEMPLATES_DIR/erc20/"* "$PROJECT_DIR/"
cd "$PROJECT_DIR"

# Replace placeholders
find . -type f \( -name "*.sol" -o -name "*.md" -o -name "*.toml" \) -exec \
    sed -i.bak \
        -e 's/{{PROJECT_NAME}}/SmokeToken/g' \
        -e 's/{{PROJECT_SLUG}}/smoketoken/g' \
        -e 's/{{TOKEN_NAME}}/SmokeToken/g' \
        -e 's/{{TOKEN_SYMBOL}}/SMOKE/g' \
        {} \;
find . -name "*.bak" -delete

echo "2. Installing dependencies..."
forge install OpenZeppelin/openzeppelin-contracts --no-git --quiet
forge install foundry-rs/forge-std --no-git --quiet

echo "3. Building..."
forge build

echo "4. Running tests..."
forge test

echo "5. Starting Anvil..."
anvil --port 8546 &
ANVIL_PID=$!
sleep 2

# Check Anvil is running
if ! curl -s http://127.0.0.1:8546 -X POST -H "Content-Type: application/json" \
    --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}' > /dev/null; then
    echo "FAIL: Anvil not responding"
    exit 1
fi

echo "6. Deploying locally..."
# Use Anvil's default account (account 0)
PRIVATE_KEY="0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"
forge script script/Deploy.s.sol --rpc-url http://127.0.0.1:8546 --broadcast --private-key "$PRIVATE_KEY"

echo "7. Calling contract..."
# Get deployed address from broadcast
DEPLOYED_ADDRESS=$(cat broadcast/Deploy.s.sol/31337/run-latest.json | grep -o '"contractAddress":"0x[^"]*"' | head -1 | cut -d'"' -f4)

if [ -z "$DEPLOYED_ADDRESS" ]; then
    echo "FAIL: Could not find deployed address"
    exit 1
fi

echo "Token deployed at: $DEPLOYED_ADDRESS"

# Call name()
NAME=$(cast call "$DEPLOYED_ADDRESS" "name()" --rpc-url http://127.0.0.1:8546)
echo "Token name: $NAME"

# Call symbol()
SYMBOL=$(cast call "$DEPLOYED_ADDRESS" "symbol()" --rpc-url http://127.0.0.1:8546)
echo "Token symbol: $SYMBOL"

echo
echo "=== Smoke Test PASSED ==="
