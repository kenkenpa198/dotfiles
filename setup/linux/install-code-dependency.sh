#!/bin/bash

set -x
set -euo pipefail
bash "${HOME}/dotfiles/setup/linux/header.sh" "Run: $0"

# 先に volta をインストールしてから実行する
# setup/linux/install-volta.sh

# Ref:
# - [JavaScript・TypeScriptのimport・exportの依存関係を可視化するcode-dependencyの紹介 \| himenon.github.io](https://himenon.github.io/docs/javascript/introduction-code-dependency/)
# - [Himenon/code-dependency: A work efficiency tool for visualizing code dependencies on a browser.](https://github.com/Himenon/code-dependency)

function main {
    cd

    # グローバルへインストール
    npm i -g @code-dependency/cli@latest

    # 依存関係の解決
    npm i -g core-js

    code-dependency --version

    set +x
    echo
    echo "Finished: $0"
}

main
