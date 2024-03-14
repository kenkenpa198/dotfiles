#!/bin/bash

set -x
set -euo pipefail
bash "${HOME}/dotfiles/setup/linux/header.sh" "Run: $0"

function link_code {
    mkdir -p ~/.config/Code/User/snippets/

    # make symlink
    ln -sf "$HOME/dotfiles/.config/Code/User/settings.json" "$HOME/.config/Code/User/"
    ln -sf "$HOME/dotfiles/.config/Code/User/keybindings.json" "$HOME/.config/Code/User/"
    ln -sf "$HOME/dotfiles/.config/Code/User/snippets/markdown.json" "$HOME/.config/Code/User/snippets/"
}

function link_git {
    mkdir -p ~/.config/git/

    # .giticonfig.local のテンプレートファイルを作成
    if [ ! -e ~/dotfiles/.config/git/local ]; then
        cp ~/dotfiles/.config/git/local.example ~/dotfiles/.config/git/local
    fi

    # シンボリックリンクを作成
    ln -sf ~/dotfiles/.config/git/config ~/.config/git/
    ln -sf ~/dotfiles/.config/git/local ~/.config/git/
    ln -sf ~/dotfiles/.config/git/ignore ~/.config/git/
}

function link_myscripts {
    local DOTFILES_BIN="$HOME/dotfiles/.local/bin"
    local LOCAL_BIN="$HOME/.local/bin"
    mkdir -p "$LOCAL_BIN"

    # 自作コマンドすべてへ実行権限を付与
    chmod -R +x "$DOTFILES_BIN"

    # シンボリックリンクを作成（ファイル毎）
    ls "$DOTFILES_BIN" | xargs -I{} ln -sf "$DOTFILES_BIN"/{} "$LOCAL_BIN"/{}
}

function link_sheldon {
    mkdir -p "$HOME/.config/sheldon"

    # シンボリックリンクを作成
    ln -sf ~/dotfiles/.config/sheldon/plugins.toml ~/.config/sheldon/plugins.toml
}

function link_xremap {
    mkdir -p ~/.config/xremap/

    # make symlink
    ln -sf "$HOME/dotfiles/.config/xremap/config.yml" "$HOME/.config/xremap/"
}

function link_zsh {
    mkdir -p "$HOME/.config/zsh"

    # .zshenv のシンボリックリンクを作成
    # 環境に存在する可能性があるのでバックアップのオプションを指定する
    ln -s --suffix=".bak.$(date +%Y%m%d%H%M%S)" ~/dotfiles/.zshenv ~/

    # 設定ファイル群のシンボリックリンクを作成
    # [lsでファイルのみリストする](https://www.yamacoco.com/program/lsでファイルのみリストする/)
    ls -aF ~/dotfiles/.config/zsh | grep -v / | xargs -I{} ln -sf ~/dotfiles/.config/zsh/{} ~/.config/zsh/{}
}

function link_wsl {
    if [ -d "/mnt/c/Users/$USER" ]; then
        mkdir -p "/mnt/c/Users/$USER/works/notes"
        ln -sfn "/mnt/c/Users/$USER/works/notes" ~/works/notes
    fi
}

function main {
    link_code
    link_git
    link_myscripts
    link_sheldon
    link_xremap
    link_zsh

    # 環境ごとの実行
    if [[ "$(uname -r)" == *microsoft* ]]; then
        link_wsl
    fi

    set +x
    echo
    echo "Finished: $0"
}

main
