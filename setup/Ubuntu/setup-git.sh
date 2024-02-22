#!/bin/bash

set -x
set -euo pipefail

# Git の設定
function main {
    # .giticonfig.local のテンプレートファイルを作成
    cp ~/dotfiles/.gitconfig.local.example ~/dotfiles/.gitconfig.local

    # シンボリックリンクを作成
    ln -sf ~/dotfiles/.gitconfig ~/
    ln -sf ~/dotfiles/.gitconfig.local ~/
    ln -sf ~/dotfiles/.gitignore_global ~/

    set +x
    echo
    echo "Finished: $0"
    echo "Please enter your [user.email] and [user.name] for Git."
    echo
    echo "    $ vim ~/.gitconfig.local"
}

main
