#!/bin/bash

set -x
set -euo pipefail

# Git の設定
function main {
    # .giticonfig.local のテンプレートファイルを作成
    if [ ! -e ~/dotfiles/.gitconfig.local ]; then
        cp ~/dotfiles/.config/git/local.example ~/dotfiles/.config/git/local
    fi

    # XDG Base Directory Specification
    mkdir -p ~/.config/git/

    # シンボリックリンクを作成
    ln -sf ~/dotfiles/.config/git/config ~/.config/git/
    ln -sf ~/dotfiles/.config/git/local ~/.config/git/
    ln -sf ~/dotfiles/.config/git/ignore ~/.config/git/

    set +x
    echo
    echo "Finished: $0"
    echo "Please enter your [user.email] and [user.name] for Git."
    echo
    echo "    $ vim ~/.config/git/local"
}

main
