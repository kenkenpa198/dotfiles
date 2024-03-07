#!/bin/bash

set -x
set -euo pipefail

function link_git {
    # .giticonfig.local のテンプレートファイルを作成
    if [ ! -e ~/dotfiles/.config/git/local ]; then
        cp ~/dotfiles/.config/git/local.example ~/dotfiles/.config/git/local
    fi

    # XDG Base Directory Specification
    mkdir -p ~/.config/git/

    # シンボリックリンクを作成
    ln -sf ~/dotfiles/.config/git/config ~/.config/git/
    ln -sf ~/dotfiles/.config/git/local ~/.config/git/
    ln -sf ~/dotfiles/.config/git/ignore ~/.config/git/
}

function link_zsh {
    # XDG Base Directory Specification
    mkdir -p "$HOME/.config/zsh"

    # .zshenv のシンボリックリンクを作成
    ln -sf ~/dotfiles/.zshenv ~/

    # 設定ファイル群のシンボリックリンクを作成
    # [lsでファイルのみリストする](https://www.yamacoco.com/program/lsでファイルのみリストする/)
    ls -aF ~/dotfiles/.config/zsh | grep -v / | xargs -I{} ln -sf ~/dotfiles/.config/zsh/{} ~/.config/zsh/{}
}

function link_sheldon {
    # XDG Base Directory Specification
    mkdir -p "$HOME/.config/sheldon"

    # シンボリックリンクを作成
    ln -sf ~/dotfiles/.config/sheldon/plugins.toml ~/.config/sheldon/plugins.toml
}

function link_wsl {
    # 環境ごとの実行
    case ${OSTYPE} in
        # Linux
        linux* | msys*)
            # WSL
            if uname -r | grep -i 'microsoft' > /dev/null ; then
                # Notes
                if [ -n "$USER" ]; then
                    mkdir -p /mnt/c/Users/"$USER"/works/notes
                    ln -sfn /mnt/c/Users/"$USER"/works/notes ~/works/notes
                fi
            fi
        ;;
        # MacOS
        darwin*)
        ;;
    esac
}

function main {
    link_git
    link_zsh
    link_sheldon
    link_wsl

    set +x
    echo
    echo "Finished: $0"
}

main
