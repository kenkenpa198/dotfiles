#!/bin/bash

set -x
set -euo pipefail
bash "${HOME}/dotfiles/setup/linux/header.sh" "Run: $0"

# Reference:
# [rbenv/rbenv-installer](https://github.com/rbenv/rbenv-installer#rbenv-installer)

function main {
    cd

    # 公式インストーラーを実行
    curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
    rbenv --version

    # apt で依存パッケージをインストール
    sudo apt update
    sudo apt install -y libyaml-dev libffi-dev
    sudo apt autoremove

    # rbenv-doctor を実行
    curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-doctor | bash

    set +x
    echo
    echo "Finished: $0"
    echo
    echo "Please install and set ruby for global:"
    echo
    echo "  $ rbenv install -l"
    echo "  $ rbenv install X.Y.Z"
    echo "  $ rbenv global X.Y.Z"
    echo
    echo "After that, check settings:"
    echo
    echo "  $ rbenv versions"
    echo "  $ ruby --version"
}

main
