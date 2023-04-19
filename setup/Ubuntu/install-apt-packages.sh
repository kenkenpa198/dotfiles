#!/bin/bash

set -x
set -euo pipefail

function main {
    # パッケージリストの取得・既存パッケージの更新
    sudo apt update && sudo apt upgrade -y

    # インストールするパッケージの配列を定義
    packages=(
        "gcc"
        "cppcheck"
        "neofetch"
        "pwgen"
        "python3-pip"
        "tree"
        "zsh"
    )

    # インストール
    for package in "${packages[@]}"
    do
        sudo apt install -y "$package"
    done

    # パッケージのキャッシュを削除
    sudo apt autoclean -y
}

main
