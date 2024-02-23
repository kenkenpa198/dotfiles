#!/bin/bash

set -x
set -euo pipefail

function main {
    # シンボリックリンクを作成
    ln -sf ~/dotfiles/config/sheldon/plugins.toml ~/.config/sheldon

    set +x
    echo
    echo "Finished: $0"
}

main
