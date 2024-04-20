#!/bin/bash

set -x
set -euo pipefail
bash "${HOME}/dotfiles/setup/linux/header.sh" "Run: $0"

function main {
    local LOCAL_BIN="$HOME/.local/bin"
    mkdir -p "$LOCAL_BIN"

    # Neos21/google-translator
    # curl https://raw.githubusercontent.com/Neos21/google-translator/master/gtr.bash > "$LOCAL_BIN/gtr"

    # すべて実行権限を付与
    chmod -R +x "$LOCAL_BIN"

    set +x
    echo
    echo "Finished: $0"
}

main
