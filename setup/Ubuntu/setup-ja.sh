#!/bin/bash

set -x
set -euo pipefail

function main {
    # パッケージリストの取得・既存パッケージの更新
    sudo apt-get update && sudo apt-get upgrade -y

    # 日本語言語パックをインストール
    sudo apt-get install -y language-pack-ja

    # 適用
    # sudo update-locale LANG=ja_JP.UTF8

    # 日本語版マニュアルのインストール
    sudo apt-get install -y manpages-ja manpages-ja-dev

    set +x
    echo
    echo "Finished: $0"
}

main
