#!/usr/bin/env bash
# Simple smoke test: waits for the frontend service to answer /healthz
# Usage: ./smoke-test.sh <url> [max_attempts]
set -euo pipefail

URL="${1:?Usage: smoke-test.sh <url> [max_attempts]}"
MAX_ATTEMPTS="${2:-15}"
SLEEP_SECONDS=4

echo "Running smoke test against: ${URL}/healthz"

for attempt in $(seq 1 "$MAX_ATTEMPTS"); do
  if curl --fail --silent --show-error "${URL}/healthz"; then
    echo ""
    echo "Smoke test passed on attempt ${attempt}"
    exit 0
  fi
  echo "Attempt ${attempt}/${MAX_ATTEMPTS} failed, retrying in ${SLEEP_SECONDS}s..."
  sleep "$SLEEP_SECONDS"
done

echo "Smoke test failed: ${URL}/healthz never became available"
exit 1
