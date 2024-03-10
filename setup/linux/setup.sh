#!/bin/bash

set -x
set -euo pipefail

###################################
# 関数定義
###################################
# 初期化処理
function init {
    : Initialize

    # pacman が存在する場合はキーリングを初期化する
    : Check pacman
    if (type "pacman" > /dev/null 2>&1); then
        : Exists pacman
        : Init pacman key
        sudo pacman-key --init
        sudo pacman-key --populate
        sudo pacman -Syy --noconfirm archlinux-keyring
    else
        : pacman is not installed
    fi

    # Git がインストールされていない場合は各パッケージマネージャでインストールする
    : Check installed Git
    if ! (type "git" > /dev/null 2>&1); then
        : Git is not installed
        if (type "pacman" > /dev/null 2>&1); then
            : Exists pacman
            : Install Git with pacman
            sudo pacman -Syu --noconfirm git
        else
            : Not exists some package managers
            : Install Git with apt
            sudo apt-get update && \
            sudo apt-get install -y git
        fi
    else
        : Git is installed
    fi

    # dotfiles を clone
    : Clone dotfiles
    local DOTFILES_HOME=${HOME}/dotfiles
    if [ ! -d "${DOTFILES_HOME}" ]; then
        git clone https://github.com/kenkenpa198/dotfiles.git "${DOTFILES_HOME}"
    else
        git -C "${DOTFILES_HOME}" pull origin main || true
    fi
}

# 環境情報を表示
function show_environment {
    : Display the current time
    date

    : Show system information
    uname -a

    : Show OS information
    cat /etc/os-release

    : Show current user name
    whoami

    : Show current shell
    echo $SHELL

    : Show environment variables
    env

    : Print working directory
    pwd
}

# XDG Base Directory Specification
function export_xdg {
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_CACHE_HOME="$HOME/.cache"
    export XDG_DATA_HOME="$HOME/.local/share"
    export XDG_STATE_HOME="$HOME/.local/state"
}

# ディレクトリを作成
function make_dir {
    # XDG Base Directory Specification
    mkdir -p "$XDG_STATE_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME"
    mkdir -p "$XDG_STATE_HOME/zsh"

    # My directory
    mkdir -p ~/works/develop
}


###################################
# メイン処理
###################################
function main {
    # 初期化処理
    init

    # ヘッダー出力
    bash "${HOME}/dotfiles/setup/linux/header.sh" "$0"

    # 環境情報を表示
    show_environment

    # XDG Base Directory Specification
    export_xdg

    # ディレクトリを作成
    make_dir

    # アプリケーションのインストール
    bash "${HOME}/dotfiles/setup/linux/install-packages.sh"
    bash "${HOME}/dotfiles/setup/linux/install-sheldon.sh"
    bash "${HOME}/dotfiles/setup/linux/install-scripts.sh"

    # シンボリックリンクを作成
    bash "${HOME}/dotfiles/setup/linux/link.sh"

    # zsh をデフォルトシェルへ設定
    sudo chsh "$USER" -s "$(which zsh)"

    # 完了メッセージを出力
    set +x
    bash "${HOME}/dotfiles/setup/linux/header.sh" "Finished: $0"
    echo "Default shell:"
    echo "$SHELL"
    echo
    echo "Git config:"
    git config -l
    echo
    echo "Please enter your [user.email] and [user.name] for Git."
    echo
    echo "    $ vim ~/.config/git/local"
    echo
    echo "Next, Please reboot host."
}

main
