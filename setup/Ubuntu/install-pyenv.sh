#!/bin/bash

# Reference:
# https://github.com/pyenv/pyenv?tab=readme-ov-file#automatic-installer

set -x
set -euo pipefail

function main {
    cd

    # 公式インストーラーを実行
    curl https://pyenv.run | bash
    pyenv --version

    set +x
    echo
    echo "Finished: $0"
    echo
    echo "Please install and set ruby for global:"
    echo
    echo "  $ pyenv install -l"
    echo "  $ pyenv install X.Y.Z"
    echo "  $ pyenv global X.Y.Z"
    echo
    echo "After that, check settings:"
    echo
    echo "  $ pyenv versions"
    echo "  $ python --version"
}

main
