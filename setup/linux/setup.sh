#!/bin/bash

set -x
set -euo pipefail

###################################
# 関数定義
###################################
function init {
    : Initialize
    # pacman が存在する場合は初期化を実行する
    if (type "pacman" > /dev/null 2>&1); then
        # キーリングの初期化
        sudo pacman-key --init
        sudo pacman-key --populate
        sudo pacman -Syy --noconfirm archlinux-keyring
    fi

    # check Git
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

# 完了メッセージを表示
function print_finished {
    set +x
    echo "---------------------------------------"
    echo "Finished: $0"
    echo "---------------------------------------"
    echo "Default shell: $SHELL"
    echo "---------------------------------------"
    echo "Git config:"
    git config -l
    echo "---------------------------------------"
    echo "Please enter your [user.email] and [user.name] for Git."
    echo
    echo "    $ vim ~/.config/git/local"
    echo
    echo "---------------------------------------"
    echo "Next, Please reboot host."
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
    bash "${HOME}/dotfiles/setup/linux/install-my-scripts.sh"
    bash "${HOME}/dotfiles/setup/linux/install-scripts.sh"

    # シンボリックリンクを作成
    bash "${HOME}/dotfiles/setup/linux/link.sh"

    # zsh をデフォルトシェルへ設定
    sudo chsh "$USER" -s "$(which zsh)"

    # 完了メッセージを出力
    print_finished
}

main
