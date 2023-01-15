# --------------
#    link.ps1
# --------------
# シンボリックリンク作成用 PowerShell スクリプト。
# クラウド環境や WSL 環境のディレクトリ・設定ファイルを Win 環境から利用できるようにする。
# WSL2 のディレクトリ上にある bat ファイルを Win 側から実行する場合、このシンボリックリンク設定を行った上で Win 側からその bat ファイルを実行したりショートカットを作成する。

# New-Item -Value <<リンク先のパス>> -Path <<リンクを置くディレクトリ>> -Name <<リンクのファイル名>> -ItemType SymbolicLink

# 参考:
# [PowerShellで苦労して作るシンボリックリンク - Qiita](https://qiita.com/tokky_se/items/128a04e861b2863e2c99)
# [Googleドライブのパスを英語に変更したい - 日日是好日](https://siromiuo.hateblo.jp/entry/2021/11/03/133144)


##### Win 環境からクラウドストレージへのリンク #####
# [Win] ~\Documents\Files ---> [Google Drive] ~\Documents\Files
New-Item -Value '~\GoogleDrive\Documents\Files' -Path '~\Documents' -Name 'Files' -ItemType SymbolicLink

# [Win] ~\Works\Create ---> [Google Drive] ~\Works\Create
New-Item -Value '~\GoogleDrive\Works\Create' -Path '~\Works' -Name 'Create' -ItemType SymbolicLink

# [Win] ~\Works\Others ---> [Google Drive] ~\Works\Others
New-Item -Value '~\GoogleDrive\Works\Others' -Path '~\Works' -Name 'Others' -ItemType SymbolicLink


##### Win 環境から WSL 環境へのリンク #####
# WSL 側のホームディレクトリパスを変数へ格納
$WSLHOME = "\\wsl.localhost\Ubuntu\home\${env:USERNAME}"

# [Win] ~\Works\Develop ---> [WSL2] ~/works/develop
New-Item -Value "${WSLHOME}\works\develop" -Path '~\Works' -Name 'Develop' -ItemType SymbolicLink

# PowerShell エイリアス設定ファイル
New-Item -Value "${WSLHOME}\dotfiles\.config\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -Path '~\Documents\WindowsPowerShell' -Name 'Microsoft.PowerShell_profile.ps1' -ItemType SymbolicLink

# VSCode 設定ファイル
New-Item -Value "${WSLHOME}\dotfiles\.config\Code\User\settings.json"    -Path '~\AppData\Roaming\Code\User' -Name 'settings.json'    -ItemType SymbolicLink
New-Item -Value "${WSLHOME}\dotfiles\.config\Code\User\keybindings.json" -Path '~\AppData\Roaming\Code\User' -Name 'keybindings.json' -ItemType SymbolicLink

# Azure Data Studio 設定ファイル
New-Item -Value "${WSLHOME}\dotfiles\.config\azuredatastudio\User\settings.json" -Path '~\AppData\Roaming\azuredatastudio\User' -Name 'settings.json' -ItemType SymbolicLink

# Git Bash .bashrc
New-Item -Value "${WSLHOME}\.bashrc" -Path '~' -Name '.bashrc' -ItemType SymbolicLink

# Obsidian 隠しファイル
New-Item -Value "${WSLHOME}\dotfiles\.config\Obsidian\MyNotes\.obsidian" -Path '~\Documents\Obsidian\MyNotes' -Name '.obsidian' -ItemType SymbolicLink


##### その他 #####
# [Win] ~\Videos\Capture ---> [D ドライブ] ~\Videos\Capture
New-Item -Value "D:\${env:USERNAME}\Videos\Capture" -Path '~\Videos' -Name 'Capture' -ItemType SymbolicLink
