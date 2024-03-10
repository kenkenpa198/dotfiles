#!/bin/bash
# 引数へ渡した文字列の見出しを出力するスクリプト

# Reference:
# [Bashシェルスクリプトで任意の文字を繰り返し出力する方法 \| ゲンゾウ用ポストイット](https://genzouw.com/entry/2020/10/29/211143/2094/)
# [ShellScriptにおいて，テキストファイル末尾に改行を加える． \#Bash - Qiita](https://qiita.com/BlackCat_617/items/00ea5db993ed31b56821)

# example:
#
#   $ bash notice.sh script-name
#   ======================================...
#   Run: script-name
#   ======================================...

function hr {
    # 1. '=' をシェルの幅分の行数で出力
    # 2. 改行コードを除去して 1 行にする
    # 3. 改行コードを行末へ加えるために awk を通して出力
    yes '=' | head -n "$(tput cols)" | tr -d '\n' | awk '1'
}

function main {
    hr
    echo "$1"
    hr
}

main "$@"
