#!/bin/bash

set -x
set -euo pipefail
: ----------------------------------------
: Run: "$0"
: ----------------------------------------

# VS Code の拡張機能をインストールするスクリプト
# VS Code の拡張機能リストを1行ずつ変数へ代入して code コマンドでインストールする。

# 実行
# $ bash ~/dotfiles/.setup/linux/install-vscode-extensions.sh

# 参考
# https://qiita.com/mottox2/items/581869563ce5f427b5f6

function main {
    cat ~/dotfiles/.config/Code/extensions | while read -r line
    do
        code --install-extension "$line"
    done

    set +x
    echo
    echo "Finished: $0"
}

main
