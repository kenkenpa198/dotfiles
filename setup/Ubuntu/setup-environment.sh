#!/bin/bash

set -x
set -euo pipefail


###################################
# 関数定義
###################################
# ディレクトリを作成
function make_dir {
    mkdir -p ~/works/develop
}

# 初期ファイルをバックアップ
function backup_origin_files {
    cp ~/.bashrc ~/.bashrc.org
}

# シンボリックリンクを配置
function link {
    # 環境ごとの実行
    case ${OSTYPE} in
        # Linux
        linux* | msys*)
            # WSL
            if uname -r | grep -i 'microsoft' > /dev/null ; then
                # Notes
                echo "$USERNAME"
                ln -sfn /mnt/c/Users/"$USERNAME"/works/notes ~/works/notes
            fi
        ;;
        # MacOS
        darwin*)
        ;;
    esac
}

# 完了メッセージを表示
function print_finished {
    set +x
    echo
    echo "Finished: $0"
}


###################################
# メイン処理
###################################
function main {
    # 初期ファイルのバックアップ
    backup_origin_files

    # ディレクトリを作成
    make_dir

    # シンボリックリンクを配置
    link

    # 完了メッセージを出力
    print_finished
}

main
