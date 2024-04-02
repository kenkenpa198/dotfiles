#!/bin/bash

set -x
set -euo pipefail
bash "${HOME}/dotfiles/setup/linux/header.sh" "Run: $0"

# nodenv インストール
# https://github.com/nodenv/nodenv-installer#nodenv-installer

function main {
    cd

    # 公式インストーラーを実行
    curl -fsSL https://github.com/nodenv/nodenv-installer/raw/HEAD/bin/nodenv-installer | bash
    nodenv --version

    # nodenv-doctor を実行
    curl -fsSL https://github.com/nodenv/nodenv-installer/raw/HEAD/bin/nodenv-doctor | bash

    set +x
    echo
    echo "Finished: $0"
    echo
    echo "Please install Node.js:
    echo
    echo "  $ nodenv install -l"
    echo "  $ nodenv install X.Y.Z"
    echo "  $ nodenv versions"
    echo
    echo "Set global version and check settings:
    echo
    echo "  $ nodenv global X.Y.Z"
    echo "  $ node --version"
}

main
