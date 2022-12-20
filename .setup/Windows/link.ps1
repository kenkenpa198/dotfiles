# ------------------
#    link.ps1
# ------------------
# シンボリックリンク作成用 PowerShell スクリプト。
# クラウド環境や WSL 環境のディレクトリ・設定ファイルを Win 環境から利用できるようにする。
# WSL2 のディレクトリ上にある bat ファイルを Win 側から実行する場合、このシンボリックリンク設定を行った上で Win 側からその bat ファイルを実行したりショートカットを作成する。
# 参考: [PowerShellで苦労して作るシンボリックリンク - Qiita](https://qiita.com/tokky_se/items/128a04e861b2863e2c99)


##### ディレクトリのリンク設定 #####
# [Win] ~\Documents\Files ---> [iCloud Drive] ~/Documents/Files
New-Item -Value '~\iCloudDrive\Documents\Files' -Path '~\Documents' -Name 'Files' -ItemType SymbolicLink

# [Win] ~\Works\Create ---> [iCloud Drive] ~/Works/Create
New-Item -Value '~\iCloudDrive\Works\Create' -Path '~\Works' -Name 'Create' -ItemType SymbolicLink

# [Win] ~\Works\Others ---> [iCloud Drive] ~/Works/Others
New-Item -Value '~\iCloudDrive\Works\Others' -Path '~\Works' -Name 'Others' -ItemType SymbolicLink

# [Win] ~\Works\Develop ---> [WSL2] ~/Works/Develop
$value = "\\wsl.localhost\Ubuntu\home\" + $env:USERNAME + "\Works\Develop"
New-Item -Value $value -Path '~\Works' -Name 'Develop' -ItemType SymbolicLink

# [Win] ~\Videos\Capture ---> [D ドライブ] ~\Videos\Capture
$value = "D:\" + $env:USERNAME + "\Videos\Capture"
New-Item -Value $value -Path '~\Videos' -Name 'Capture' -ItemType SymbolicLink

# [Win] ~/dotfiles ---> [WSL2] ~/dotfiles
# 次以降の設定ファイルのリンクに必須
$value = "\\wsl.localhost\Ubuntu\home\" + $env:USERNAME + "\dotfiles"
New-Item -Value $value -Path '~' -Name 'dotfiles' -ItemType SymbolicLink


##### 設定ファイルのリンク設定 #####
# PowerShell エイリアス設定ファイル
New-Item -Value '~\dotfiles\.config\WindowsPowerShell\Microsoft.PowerShell_profile.ps1' -Path '~\Documents\WindowsPowerShell' -Name 'Microsoft.PowerShell_profile.ps1' -ItemType SymbolicLink

# VSCode 設定ファイル
New-Item -Value '~\dotfiles\.config\Code\User\settings.json' -Path '~\AppData\Roaming\Code\User' -Name 'settings.json' -ItemType SymbolicLink
New-Item -Value '~\dotfiles\.config\Code\User\keybindings.json' -Path '~\AppData\Roaming\Code\User' -Name 'keybindings.json' -ItemType SymbolicLink

# Azure Data Studio 設定ファイル
New-Item -Value '~\dotfiles\.config\azuredatastudio\User\settings.json' -Path '~\AppData\Roaming\azuredatastudio\User' -Name 'settings.json' -ItemType SymbolicLink

# Git Bash
New-Item -Value '~\dotfiles\.bashrc' -Path '~' -Name '.bashrc' -ItemType SymbolicLink
