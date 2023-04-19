#!/bin/bash

set -x
set -euo pipefail

function main {
    # 自作コマンドの実行権限付与
    cd ~/dotfiles/bin
    chmod +x acd cj moda

    # シンボリックリンクを作成
    sudo ln -sf ~/dotfiles/bin/acd /usr/local/bin/
    sudo ln -sf ~/dotfiles/bin/cj /usr/local/bin/
    sudo ln -sf ~/dotfiles/bin/moda /usr/local/bin/

}

main
