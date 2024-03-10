#!/bin/bash
# 引数へ渡した文字列の見出しを出力するスクリプト
# Reference: [Bashシェルスクリプトで任意の文字を繰り返し出力する方法 \| ゲンゾウ用ポストイット](https://genzouw.com/entry/2020/10/29/211143/2094/)

# example:
#
#   $ bash notice.sh script-name
#   ======================================...
#   Run: script-name
#   ======================================...

function hr {
    yes '=' | head -n "$(tput cols)" | tr -d '\n'
}

function main {
    hr
    echo Run: "$1"
    hr
}

main "$@"
