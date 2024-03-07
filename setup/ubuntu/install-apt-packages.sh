#!/bin/bash

set -x
set -euo pipefail

function main {
    # パッケージリストの取得・既存パッケージの更新
    sudo apt-get update && sudo apt-get upgrade -y

    # インストールするパッケージの配列を定義
    packages=(
        "gcc"
        "cppcheck"
        "neofetch"
        "pwgen"
        "software-properties-common"
        "tree"
        "zsh"
    )

    # インストール
    for package in "${packages[@]}"
    do
        sudo apt-get install -y "$package"
    done

    # パッケージのキャッシュを削除
    sudo apt-get autoclean -y

    set +x
    echo
    echo "Finished: $0"
}

main
