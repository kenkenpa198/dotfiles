#!/bin/bash

set -x
set -euo pipefail
bash "${HOME}/dotfiles/setup/linux/header.sh" "Run: $0"

# apt でインストールする
function install_with_apt {
    # パッケージリストの取得・既存パッケージの更新
    sudo apt-get update && sudo apt-get upgrade -y

    # インストール
    sudo apt-get install -y "${packages[@]}"

    # Git は PPA からインストールし直す
    # https://loumo.jp/archives/23149
    sudo add-apt-repository -y ppa:git-core/ppa
    sudo apt-get install -y git

    # パッケージのキャッシュを削除
    sudo apt-get autoclean -y
}

# pacman でインストールする
function install_with_pacman {
    # [pacman - ArchWiki](https://wiki.archlinux.jp/index.php/Pacman)

    # パッケージリストの取得・既存パッケージの更新
    sudo pacman -Syu --noconfirm

    # インストール
    sudo pacman -S --noconfirm "${packages[@]}"

    # パッケージのキャッシュを削除
    paccache -rk1   # 最も新しいバージョン1つだけを保持
    paccache -ruk0  # アンインストールされたパッケージのキャッシュを全て削除
}

function main {
    # インストールするパッケージの配列を定義
    local packages=(
        "cppcheck"
        "curl"
        "gcc"
        "git"
        "jq"
        "neofetch"
        "pwgen"
        "tree"
        "vim"
        "wget"
        "zsh"
    )

    # 利用するパッケージマネージャの分岐
    if (type "pacman" > /dev/null 2>&1); then
        : Exists pacman
        : add packages for pacman
        local packages+=(
            "openssh"
            "pacman-contrib"
            "which"
        )
        : Install with pacman
        install_with_pacman
    else
        : Not exists some package managers
        : add packages for apt
        local packages+=(
            "openssh-server"
            "software-properties-common"
        )
        : Install with apt
        install_with_apt
    fi

    set +x
    echo
    echo "Finished: $0"
}

main
