#!/usr/bin/env bash
set -euo pipefail

# Validate all templates compile and pass tests

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
TEMPLATES_DIR="$ROOT_DIR/plugins/contractkit/templates"

echo "=== ContractKit Template Validation ==="
echo

failed=0

for template_dir in "$TEMPLATES_DIR"/*/; do
    template_name=$(basename "$template_dir")

    # Skip _shared directory
    if [ "$template_name" = "_shared" ]; then
        continue
    fi

    # Skip if no foundry.toml
    if [ ! -f "$template_dir/foundry.toml" ]; then
        continue
    fi

    echo "--- Validating: $template_name ---"

    # Create temp directory and copy template
    tmp_dir=$(mktemp -d)
    cp -r "$template_dir"/* "$tmp_dir/"
    cd "$tmp_dir"

    # Replace placeholders with test values
    find . -type f \( -name "*.sol" -o -name "*.md" -o -name "*.toml" \) -exec \
        sed -i.bak \
            -e 's/{{PROJECT_NAME}}/TestProject/g' \
            -e 's/{{PROJECT_SLUG}}/testproject/g' \
            -e 's/{{TOKEN_NAME}}/TestToken/g' \
            -e 's/{{TOKEN_SYMBOL}}/TEST/g' \
            {} \;
    find . -name "*.bak" -delete

    # Install dependencies
    echo "Installing dependencies..."
    forge install OpenZeppelin/openzeppelin-contracts --no-commit --quiet || true
    forge install foundry-rs/forge-std --no-commit --quiet || true

    # Check formatting
    echo "Checking format..."
    if ! forge fmt --check 2>/dev/null; then
        echo "WARN: Format check failed (may need forge fmt)"
    fi

    # Build
    echo "Building..."
    if ! forge build; then
        echo "FAIL: Build failed for $template_name"
        failed=1
        cd - > /dev/null
        rm -rf "$tmp_dir"
        continue
    fi

    # Test
    echo "Testing..."
    if ! forge test; then
        echo "FAIL: Tests failed for $template_name"
        failed=1
        cd - > /dev/null
        rm -rf "$tmp_dir"
        continue
    fi

    echo "PASS: $template_name"
    echo

    cd - > /dev/null
    rm -rf "$tmp_dir"
done

echo "=== Validation Complete ==="

if [ $failed -eq 1 ]; then
    echo "Some templates failed validation"
    exit 1
fi

echo "All templates passed"
