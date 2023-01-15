#!/bin/bash

# Ubuntu 環境の初期セットアップ用スクリプト
# 先に以下の対応を行っておき実行する。
#
# - SSH キーの作成・GitHub アカウントへ公開鍵を登録（git clone に必要）
# - イーサネットアダプターの IPv6 を無効にする（$ sudo apt-add-repository ppa:foo/bar に必要）

set -euo pipefail

###################################
# 関数定義 : 初期環境の構築
###################################
# 初期ファイルをバックアップ
function backup_origin_files {
    cd

    cp .bashrc .bashrc.org
}


###################################
# 関数定義 : インストール関連
###################################
# apt インストール
function install_apt_apps {
    cd

    # Git 公式のリポジトリを apt リポジトリへ追加
    # https://loumo.jp/archives/23149
    sudo add-apt-repository -y ppa:git-core/ppa

    # Brighit Box の ruby リポジトリを apt リポジトリへ追加
    # https://jekyllrb-ja.github.io/docs/installation/windows/
    sudo apt-add-repository ppa:brightbox/ruby-ng

    # パッケージリストの取得・既存パッケージの更新
    sudo apt update && sudo apt upgrade -y

    # git
    sudo apt install -y git
    git --version

    # GNU Compiler Collection
    sudo apt install -y gcc
    gcc --version

    # Cppcheck
    sudo apt install -y cppcheck
    cppcheck --version

    # neofetch
    sudo apt install -y neofetch
    neofetch --version

    # pwgen
    sudo apt install -y pwgen
    pwgen --version

    # Python
    sudo apt install -y python3-pip
    pip3 --version

    # Ruby
    # https://jekyllrb-ja.github.io/docs/installation/ubuntu/
    sudo apt-get install -y ruby-full build-essential zlib1g-dev
    ruby --version
    gem --version

    # tree
    sudo apt install -y tree
    tree --version

    # zsh
    sudo apt install -y zsh
    zsh --version

    # パッケージのキャッシュを削除
    sudo apt autoclean -y
}

# Node.js インストール
# apt-get で Node.js を直接インストールできるが、
# 古いバージョン（v10系）しかインストールできないため nvm でインストールする。
#
# nvm のインストール確認以降がうまくいかなかった場合、再起動して nvm --version から再開する。
#
# 参考: https://docs.microsoft.com/ja-jp/windows/dev-environment/javascript/nodejs-on-wsl
function install_node_js {
    cd

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    nvm --version

    nvm ls            # バージョン一覧を表示して N/A と表示されることを確認
    nvm install --lts # Node.jsの安定版をインストール
    nvm ls            # 安定バージョンが入っていることを確認
}

# Ruby gems インストール
function install_gems {
    cd

    # gem 本体をアップデート
    sudo gem update --system

    # gems をアップデート
    gem update

    # Jekyll
    # https://jekyllrb-ja.github.io/docs/installation/ubuntu/
    gem install jekyll bundler
    jekyll --version

    # $ jekyll --version で Ignoring ... が出たときは以下を実行する
    # $ sudo gem pristine --all
    # TODO: gem pristine foo-gem --version 3.1.3 を個別で実行することしか試していないので次は上記コマンドで試す
}

# 自作スクリプトのインストール
function install_my_scripts {
    cd

    mkdir ~/bin
    mkdir -p ~/works/develop

    # archive-commit-diff
    # https://github.com/kenkenpa198/archive-commit-diff
    cd ~/works/develop
    git clone git@github.com:kenkenpa198/archive-commit-diff.git

    cd archive-commit-diff
    chmod +x acd.sh
    ln -s ~/works/develop/archive-commit-diff/acd.sh ~/bin/acd

    # kem-ahks
    # https://github.com/kenkenpa198/kem-ahks
    cd ~/works/develop
    git clone git@github.com:kenkenpa198/kem-ahks.git

    # kems-clew.net
    # https://github.com/kenkenpa198/kems-clew.net
    cd ~/works/develop
    git clone git@github.com:kenkenpa198/kems-clew.net.git
}

# インストール用の関数をまとめた関数
function install_my_apps {
    cd

    # apt インストール
    install_apt_apps

    # Node.js のインストール
    install_node_js

    # Ruby gems のインストール
    install_gems

    # 自作スクリプトのインストール
    install_my_scriptss
}


###################################
# 関数定義 : 設定関連
###################################
# Git の設定
function set_git {
    cd

    # シンボリックリンク設定
    ln -s ~/dotfiles/.gitignore_global ~/                     # .gitignore_global のシンボリックリンクを作成
    ln -s ~/dotfiles/.gitconfig_shared ~/                     # .gitconfig_shared のシンボリックリンクを作成
    git config --global core.excludesfile ~/.gitignore_global # .gitconfig へ .gitconfig_global を読み込み設定
    git config --global include.path ~/.gitconfig_shared      # .gitconfig へ .gitconfig_shared を外部読み込み設定
}

# zsh の設定
function set_zsh {
    cd

    # シンボリックリンク設定
    ln -s ~/dotfiles/.zshrc ~/

    # デフォルトシェルへ設定
    chsh -s "$(which zsh)"
}


###################################
# 関数定義 : その他
###################################
# 完了メッセージを表示
function print_finished {
    cat \
<< msg
setup.sh の実行を完了しました。
以下の対応を行ってください。

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

    # アプリケーションのインストール
    install_my_apps

    # Git の設定
    set_git

    # zsh をデフォルトシェルに設定
    set_zsh

    # 完了メッセージを出力
    print_finished
}

main
