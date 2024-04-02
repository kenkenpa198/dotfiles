#!/bin/bash

set -x
set -euo pipefail
bash "${HOME}/dotfiles/setup/linux/header.sh" "Run: $0"

# Reference:
# [pyenv/pyenv > Automatic installer](https://github.com/pyenv/pyenv?tab=readme-ov-file#automatic-installer)

function main {
    cd

    # 公式インストーラーを実行
    curl https://pyenv.run | bash
    pyenv --version

    set +x
    echo
    echo "Finished: $0"
    echo
    echo "Please install Python:
    echo
    echo "  $ pyenv install -l"
    echo "  $ pyenv install X.Y.Z"
    echo "  $ pyenv versions"
    echo
    echo "Set global version and check settings:
    echo
    echo "  $ pyenv global X.Y.Z"
    echo "  $ python --version"
}

main
