#!/bin/bash

set -euo pipefail

# VS Code の拡張機能をインストールするスクリプト
# VS Code の拡張機能リストを1行ずつ変数へ代入して code コマンドでインストールする。

# 実行
# $ bash ~/dotfiles/.setup/Ubuntu/install-vscode-extensions.sh

# 参考
# https://qiita.com/mottox2/items/581869563ce5f427b5f6

function main {
    cat ~/dotfiles/.config/Code/extensions | while read -r line
    do
        code --install-extension "$line"
    done
}

main