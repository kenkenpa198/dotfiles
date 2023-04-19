#!/bin/bash

set -x
set -euo pipefail

function main {
    # パッケージリストの取得・既存パッケージの更新
    sudo apt-get update && sudo apt-get upgrade -y

    # Brighit Box の ruby リポジトリを apt リポジトリへ追加
    # https://jekyllrb-ja.github.io/docs/installation/windows/
    # タイムアウトになる場合、イーサネットアダプターの IPv6 を無効にして実行する
    sudo apt-add-repository ppa:brightbox/ruby-ng

    # Ruby インストール
    # https://jekyllrb-ja.github.io/docs/installation/ubuntu/
    sudo apt-get install -y ruby-full build-essential zlib1g-dev
    ruby --version
    gem --version

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

    # パッケージのキャッシュを削除
    sudo apt-get autoclean -y
}

main
