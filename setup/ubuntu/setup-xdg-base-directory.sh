#!/bin/bash

set -x
set -euo pipefail

function main {
    mkdir -p "$HOME/.config/" "$HOME/.cache/" "$HOME/.local/share/" "$HOME/.local/state/"
}

main
