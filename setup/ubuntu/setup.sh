#!/bin/bash

set -x
set -euo pipefail


###################################
# 関数定義
###################################
# XDG Base Directory Specification
function export_xdg {
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_CACHE_HOME="$HOME/.cache"
    export XDG_DATA_HOME="$HOME/.local/share"
    export XDG_STATE_HOME="$HOME/.local/state"
}

# git clone dotfiles
function clone_dotfiles {
    dotfiles_home=${HOME}/dotfiles

    if [ ! -d "${dotfiles_home}" ]; then
        git clone https://github.com/kenkenpa198/dotfiles.git "${dotfiles_home}"
    else
        git -C "${dotfiles_home}" pull origin main || true
    fi
}

# ディレクトリを作成
function make_dir {
    # XDG Base Directory Specification
    mkdir -p "$XDG_STATE_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME"
    mkdir -p "$XDG_STATE_HOME/zsh"

    # My directory
    mkdir -p ~/works/develop
}

# 初期ファイルをバックアップ
function backup_origin_files {
    cp ~/.bashrc ~/.bashrc.org
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
    # スクリプトファイルの配置場所をカレントディレクトリとする
    # https://memo.yammer.jp/posts/shell-pwd
    SCRIPT_DIR=`dirname $0`
    cd "$SCRIPT_DIR"

    # XDG Base Directory Specification
    export_xdg

    # git clone dotfiles
    clone_dotfiles

    # ディレクトリを作成
    make_dir

    # 初期ファイルをバックアップ
    backup_origin_files

    # アプリケーションのインストール
    bash ./setup/ubuntu/install-git.sh
    bash ./setup/ubuntu/install-apt-packages.sh
    bash ./setup/ubuntu/install-sheldon.sh
    bash ./setup/ubuntu/install-my-scripts.sh

    # シンボリックリンクを作成
    bash ./setup/ubuntu/link.sh

    # zsh をデフォルトシェルへ設定
    sudo chsh "$USER" -s "$(which zsh)"

    # 完了メッセージを出力
    print_finished
}

main
