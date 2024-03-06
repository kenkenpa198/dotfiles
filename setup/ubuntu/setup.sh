#!/bin/bash

set -x
set -euo pipefail


###################################
# 関数定義
###################################
# ディレクトリを作成
function make_dir {
    # My directory
    mkdir -p ~/works/develop

    # XDG Base Directory Specification
    mkdir -p "$HOME/.config/" "$HOME/.cache/" "$HOME/.local/share/" "$HOME/.local/state/"
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
    # ディレクトリを作成
    make_dir

    # 初期ファイルをバックアップ
    backup_origin_files

    # アプリケーションのインストール
    bash ~/dotfiles/setup/ubuntu/install-git.sh
    bash ~/dotfiles/setup/ubuntu/install-apt-packages.sh
    bash ~/dotfiles/setup/ubuntu/install-sheldon.sh
    bash ~/dotfiles/setup/ubuntu/install-my-scripts.sh

    # シンボリックリンクを作成
    bash ~/dotfiles/setup/ubuntu/link.sh

    # zsh をデフォルトシェルへ設定
    chsh -s "$(which zsh)"

    # 完了メッセージを出力
    print_finished
}

main
