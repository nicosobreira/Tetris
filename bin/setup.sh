#!/usr/bin/env bash

set -euo pipefail

export NAME="SuperGame"
export GAME="$NAME.love"
export VERSION="11.5"

if [[ -f "$GAME" ]]; then
    echo "Deleting $GAME"
    rm -r "$GAME"
fi

echo "Ziping $GAME"
zip -9 -r "$GAME" "../src/"
