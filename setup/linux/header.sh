#!/bin/bash
# 引数へ渡した文字列の見出しを出力するスクリプト

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
