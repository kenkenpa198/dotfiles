#!/bin/bash

set -x
set -euo pipefail
bash "${HOME}/dotfiles/setup/linux/header.sh" "Run: $0"

# Node.js インストール
# - [Getting Started \| Volta](https://docs.volta.sh/guide/getting-started)
# - [VoltaでグローバルのNode.jsを変更 - Minerva](https://minerva.mamansoft.net/Notes/VoltaでグローバルのNode.jsを変更)

function main {
    cd

    # 公式インストーラーを実行
    curl https://get.volta.sh | bash
    volta --version

    set +x
    echo
    echo "Finished: $0"
    echo
    echo "Install and set Node.js:"
    echo
    echo "  $ volta install node"
    echo "  $ volta install node@X.Y.Z"
    echo "  $ volta list all"
    echo
    echo "Install and set Package managers:"
    echo
    echo "  $ volta install npm"
    echo "  $ volta install yarn"
    echo "  $ volta install yarn@1.22.22"
    echo "  $ volta list all"
    echo
    echo "Check:"
    echo
    echo "  $ node --version"
    echo "  $ npm --version"
    echo "  $ yarn --version"
}

main
