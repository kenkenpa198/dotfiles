#!/bin/bash

set -x
set -euo pipefail

function main {
    # .giticonfig.local のテンプレートファイルを作成
    cp ~/dotfiles/.gitconfig.local.example ~/dotfiles/.gitconfig.local

    # シンボリックリンクを作成
    ln -sf ~/dotfiles/config/sheldon/plugins.toml ~/.config/sheldon

    set +x
    echo
    echo "Finished: $0"
}

main
