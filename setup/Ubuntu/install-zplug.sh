#!/bin/bash
# https://github.com/zplug/zplug?tab=readme-ov-file

set -x
set -euo pipefail

function main {
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
}

main
