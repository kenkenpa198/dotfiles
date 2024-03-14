#!/bin/bash

set -x
set -euo pipefail
bash "${HOME}/dotfiles/setup/linux/header.sh" "Run: $0"

function main {

    # インストールするパッケージの配列を定義
    local packages=(
        "visual-studio-code-bin"
        "google-chrome"
        "aur/ttf-hackgen"
        "xremap-kde-bin"
    )

    # パッケージリストの取得・既存パッケージの更新
    yay -Syu --noconfirm

    # インストール
    yay -S --noconfirm "${packages[@]}"

    set +x
    echo
    echo "Finished: $0"
}

main
