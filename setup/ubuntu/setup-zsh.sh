#!/bin/bash

set -x
set -euo pipefail

function main {
    # シンボリックリンクを作成
    ln -sf ~/dotfiles/.zshrc ~/

    # デフォルトシェルへ設定
    chsh -s "$(which zsh)"

    # デフォルトシェルを表示
    echo "Default shell: $SHELL"

    set +x
    echo
    echo "Finished: $0"
    echo "Please reboot host."
}

main
