#!/bin/bash

set -x
set -euo pipefail

function main {
    # 自作コマンドすべてへ実行権限を付与
    chmod -R +x ~/dotfiles/bin

    # シンボリックリンクを作成
    ln -sf ~/dotfiles/bin ~/bin
}

main
