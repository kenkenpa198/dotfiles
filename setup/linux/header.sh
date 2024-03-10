#!/bin/bash
# 引数へ渡した文字列の見出しを出力するスクリプト

# 説明と参考文献は次のスクリプトに記載
#   .local/bin/hr

# example:
#
#   $ bash header.sh "fuga"
#   ======================================...
#   fuga
#   ======================================...

function hr {
    yes '=' | head -n "$(tput cols)" | tr -d '\n' | awk '1'
}

function main {
    hr
    echo "$1"
    hr
}

main "$@"
