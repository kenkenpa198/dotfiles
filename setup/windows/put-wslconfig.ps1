# エラーが発生した時点で処理を中断する
$ErrorActionPreference = 'Stop'

function main {
    $DOTFILES_HOME = "\\wsl.localhost\Ubuntu\home\${env:USERNAME}\dotfiles"
    Copy-Item "${DOTFILES_HOME}\.config\WSL\.wslconfig" ~\
}

main
