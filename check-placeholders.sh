#!/usr/bin/env bash
# Pre-deploy guard: fail if unresolved copy placeholders are still in the site.
#
# The London & North Kent pages shipped from Claude Design with placeholder
# tokens for values we did not have yet (London phone number, London price
# list, Ebbsfleet postcode). Those must be replaced with real values before
# anything goes live — the footer placeholder shows on every page of the site.
#
# Run from the repo root:   bash check-placeholders.sh
# Exit 0 = clean, exit 1 = placeholders still present.

set -uo pipefail
cd "$(dirname "$0")"

# [DATE] in privacy-policy.dc.html predates the London work and is excluded.
PATTERN='\[LONDON NUMBER\]|\[London number\]|\[EBBSFLEET POSTCODE\]|£\[X\]|\[YOUR EMAIL\]'

total=0
found=0

while IFS= read -r -d '' file; do
  n=$(grep -oE "$PATTERN" "$file" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$n" -gt 0 ]; then
    if [ "$found" -eq 0 ]; then
      echo "BLOCKED — unresolved placeholders still in customer-facing copy:"
      echo
      found=1
    fi
    printf '  %4s  %s\n' "$n" "$file"
    total=$(( total + n ))
  fi
done < <(find . -name '*.html' \
            -not -path './.git/*' -not -path './.build/*' \
            -not -path './node_modules/*' -print0 | sort -z)

if [ "$found" -eq 1 ]; then
  echo
  echo "  total: $total instances"
  echo
  echo "Replace them with real values, then re-run this check before deploying."
  exit 1
fi

echo "OK — no unresolved placeholders. Safe to deploy."
exit 0
