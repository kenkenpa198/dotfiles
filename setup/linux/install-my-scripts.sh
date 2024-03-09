#!/bin/bash

set -x
set -euo pipefail

function main {
    DOTFILES_BIN="$HOME/dotfiles/.local/bin"
    LOCAL_BIN="$HOME/.local/bin"

    # 自作コマンドすべてへ実行権限を付与
    chmod -R +x "$DOTFILES_BIN"

    # bin ディレクトリを作成
    mkdir -p "$LOCAL_BIN"

    # シンボリックリンクを作成（ファイル毎）
    ls "$DOTFILES_BIN" | xargs -I{} ln -sf "$DOTFILES_BIN"/{} "$LOCAL_BIN"/{}

    set +x
    echo
    echo "Finished: $0"
}

main
