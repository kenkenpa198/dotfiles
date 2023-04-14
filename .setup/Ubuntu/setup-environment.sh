#!/bin/bash

# Ubuntu 環境の初期セットアップ用スクリプト

set -x
set -euo pipefail


###################################
# 関数定義
###################################
# 初期ファイルをバックアップ
function backup_origin_files {
    cp ~/.bashrc ~/.bashrc.org
}

# Git の設定
function set_git {
    # シンボリックリンクを作成
    ln -s ~/dotfiles/.gitignore_global ~/
    ln -s ~/dotfiles/.gitconfig_shared ~/

    # .gitconfig へ書き込み
    git config --global core.excludesfile ~/.gitignore_global # .gitconfig へ .gitconfig_global を読み込み設定
    git config --global include.path ~/.gitconfig_shared      # .gitconfig へ .gitconfig_shared を外部読み込み設定
}

# zsh の設定
function set_zsh {
    # シンボリックリンクを作成
    ln -s ~/dotfiles/.zshrc ~/

    # デフォルトシェルへ設定
    chsh -s "$(which zsh)"
}

# 完了メッセージを表示
function print_finished {
    cat << msg
setup.sh の実行を完了しました。
下記の対応を行ってください。

- デフォルトシェルが zsh へ変更されていることを確認してください。
    $ echo \$SHELL
- Git のユーザー名とメールアドレスを登録してください。
    $ git config --global user.name <<username>>
    $ git config --global user.email <<email address>>'
- ホストを再起動してください。
msg
}


###################################
# メイン処理
###################################
function main {
    # 初期ファイルのバックアップ
    backup_origin_files

    # Git の設定
    set_git

    # zsh をデフォルトシェルに設定
    set_zsh

    # 完了メッセージを出力
    print_finished
}

main
