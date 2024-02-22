#!/bin/bash
# https://sheldon.cli.rs/Installation.html

set -x
set -euo pipefail

function main {
    curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
        | bash -s -- --repo rossmacarthur/sheldon --to ~/.local/bin

    set +x
    echo
    echo "Finished: $0"
}

main
