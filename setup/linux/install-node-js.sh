#!/bin/bash

set -x
set -euo pipefail
bash header.sh "$0"

# Node.js インストール
# apt-get で Node.js を直接インストールできるが、
# 古いバージョン（v10系）しかインストールできないため nvm でインストールする。
#
# nvm のインストール確認以降がうまくいかなかった場合、再起動して nvm --version から再開する。
#
# 参考: https://docs.microsoft.com/ja-jp/windows/dev-environment/javascript/nodejs-on-wsl

function main {
    cd

    # インストール用スクリプトを実行
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    nvm --version

    nvm ls            # バージョン一覧を表示して N/A と表示されることを確認
    nvm install --lts # Node.jsの安定版をインストール
    nvm ls            # 安定バージョンが入っていることを確認

    set +x
    echo
    echo "Finished: $0"
}

main
