#!/bin/bash

set -x
set -euo pipefail
bash "${HOME}/dotfiles/setup/linux/header.sh" "Run: $0"

function main {
    if [ ! -e ~/.local/bin/sheldon ]; then
        # https://sheldon.cli.rs/Installation.html
        curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
            | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin
    fi

    set +x
    echo
    echo "Finished: $0"
}

main
