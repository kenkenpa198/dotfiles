#!/bin/bash

set -x
set -euo pipefail

function main {
    # 自作コマンドすべてへ実行権限を付与
    chmod -R +x ~/dotfiles/bin

    # ~/bin/ を作成
    mkdir -p ~/bin

    # シンボリックリンクを作成（ファイル毎）
    ls ~/dotfiles/bin | xargs -I{} ln -sf ~/dotfiles/bin/{} ~/bin/{}

    # シンボリックリンクを作成（ディレクトリ）
    # ln -sf ~/dotfiles/bin ~/bin

    set +x
    echo
    echo "Finished: $0"
}

main
