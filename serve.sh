#!/usr/bin/env bash
# Serve ONLY the public files (never .git or other repo files) for local testing.
#   ./serve.sh                    -> http://127.0.0.1:8000
#   HOST=0.0.0.0 PORT=8080 ./serve.sh
set -euo pipefail
cd "$(dirname "$0")"
dir="$(mktemp -d)"; trap 'rm -rf "$dir"' EXIT
cp index.html "$dir"/; cp -r sounds "$dir"/
cd "$dir" && exec python3 -m http.server "${PORT:-8000}" --bind "${HOST:-127.0.0.1}"
