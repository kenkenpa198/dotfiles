#!/bin/bash

set -x
set -euo pipefail
bash "${HOME}/dotfiles/setup/linux/header.sh" "Run: $0"

# Node.js インストール
# https://github.com/nvm-sh/nvm?tab=readme-ov-file#install--update-script

function main {
    cd

    # 公式インストーラーを実行
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    nvm --version

    set +x
    echo
    echo "Finished: $0"
    echo
    echo "Please install Node.js:
    echo
    echo "  $ nvm ls-remote"
    echo "  $ nvm install --lts"
    echo "  $ nvm install X.Y.Z"
    echo "  $ nvm ls"
    echo
    echo "Set global version and check:
    echo
    echo "  $ nvm use X.Y.Z"
    echo "  $ node --version"
}

main
