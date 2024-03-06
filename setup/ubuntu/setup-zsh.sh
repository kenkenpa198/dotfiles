#!/bin/bash

set -x
set -euo pipefail

function main {
    # XDG Base Directory Specification
    mkdir -p "$HOME/.config/zsh"

    # .zshenv のシンボリックリンクを作成
    ln -sf ~/dotfiles/.zshenv ~/

    # 設定ファイル群のシンボリックリンクを作成
    # [lsでファイルのみリストする](https://www.yamacoco.com/program/lsでファイルのみリストする/)
    ls -aF ~/dotfiles/.config/zsh | grep -v / | xargs -I{} ln -sf ~/dotfiles/.config/zsh/{} ~/.config/zsh/{}

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
