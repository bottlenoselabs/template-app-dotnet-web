#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

echo "Starting LoremIpsum..."
docker compose up --build --detach --wait "$@"

echo
echo "LoremIpsum is running:"
echo "  Web: http://localhost:5200"
echo "  Api: http://localhost:5117"
