#!/bin/bash

set -x
set -euo pipefail

function main {
    # パッケージリストの取得・既存パッケージの更新
    sudo apt update && sudo apt upgrade -y

    # Git 公式のリポジトリを apt リポジトリへ追加
    # https://loumo.jp/archives/23149
    # タイムアウトになる場合、イーサネットアダプターの IPv6 を無効にして実行する
    sudo add-apt-repository -y ppa:git-core/ppa

    # インストール
    sudo apt install -y git

    # パッケージのキャッシュを削除
    sudo apt autoclean -y
}

main
