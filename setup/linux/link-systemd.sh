#!/bin/bash

set -x
set -euo pipefail
bash "${HOME}/dotfiles/setup/linux/header.sh" "Run: $0"

function link_systemd {
    mkdir -p ~/.config/systemd/user

    # cp
    # .giticonfig.local のテンプレートファイルを作成
    if [ ! -e ~/dotfiles/.config/systemd/user/xremap.service ]; then
        cp ~/dotfiles/.config/systemd/user/xremap.service.sample ~/dotfiles/.config/systemd/user/xremap.service
    fi

    # make symlink
    ln -sf "$HOME/dotfiles/.config/systemd/user/xremap.service" "$HOME/.config/systemd/user/"
}

function main {
    link_systemd

    set +x
    echo
    echo "Finished: $0"
    echo "Please enter your user name to service files."
    echo "  $ vim ~/.config/systemd/user/xremap.service"
    echo
    echo "Enable service"
    echo "  $ systemctl --user enable xremap"
    echo
    echo "Next, Please reboot host."
}

main
