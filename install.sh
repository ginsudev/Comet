#!/usr/bin/env bash
set -euo pipefail

# Installs the Comet NIC template into $THEOS/templates/.
# Usage: ./install.sh [path_to_theos]

THEOS="${1:-${THEOS:-$HOME/theos}}"

cd "$(dirname "$0")"

if [[ ! -x "$THEOS/bin/nicify.pl" ]]; then
    echo "error: nicify.pl not found at $THEOS/bin/nicify.pl" >&2
    echo "       Is THEOS set correctly?" >&2
    exit 1
fi

mkdir -p "$THEOS/templates"

echo "==> Packing Comet NIC template…"
(
    cd templates
    "$THEOS/bin/nicify.pl" comet-prefs
    mv -f iphone_comet-prefs.nic.tar "$THEOS/templates/"
)

echo "==> Installed to $THEOS/templates/iphone_comet-prefs.nic.tar"
echo "==> Scaffold a prefs bundle with: $THEOS/bin/nic.pl"
