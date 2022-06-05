:: シンボリックリンク作成用 bat ファイル

:: CMD を管理者権限で開いてコマンドを実行する。
:: たぶん bat 実行で一気に繋げられるはず（未検証）。


:::: mklink dirs ::::
:: Win 環境上からクラウドや WSL2 環境など各所へアクセスできるようにするためのシンボリックリンク設定。

:: WSL2 のディレクトリ上にある bat ファイルを Win 側から実行する場合は、
:: このシンボリックリンク設定を行った上で Win 側からその bat ファイルを実行したりショートカットを作成する。

:: [Win] ホームディレクトリ > Documents > Files ディレクトリ ---> [iCloud Drive] ホームディレクトリ > Documents > Files ディレクトリ
mklink /D %USERPROFILE%\Documents\Files %USERPROFILE%\iCloudDrive\Documents\Files

:: [Win] ホームディレクトリ > Works > Create ディレクトリ ---> [iCloud Drive] ホームディレクトリ > Works > Create ディレクトリ
mklink /D %USERPROFILE%\Works\Create %USERPROFILE%\iCloudDrive\Works\Create

:: [Win] ホームディレクトリ > Works > Others ディレクトリ ---> [iCloud Drive] ホームディレクトリ > Works > Others ディレクトリ
mklink /D %USERPROFILE%\Works\Others %USERPROFILE%\iCloudDrive\Works\Others

:: [Win] ホームディレクトリ > Works > Develop ディレクトリ ---> [WSL2] ホームディレクトリ > Works > Develop ディレクトリ
mklink /D %USERPROFILE%\Works\Develop \\wsl.localhost\Ubuntu\home\%USERNAME%\Works\Develop

:: [Win] ホームディレクトリ > Videos > Capture ディレクトリ ---> [D ドライブ] ホームディレクトリ > Videos > Capture ディレクトリ
mklink /D %USERPROFILE%\Videos\Capture D:\%USERNAME%\Videos\Capture

:: [Win] ホームディレクトリ > dotfiles ディレクトリ ---> [WSL2] ホームディレクトリ > dotfiles ディレクトリ
:: 次以降の設定ファイル同期用シンボリックリンク設定に必須。
mklink /D %USERPROFILE%\dotfiles \\wsl.localhost\Ubuntu\home\%USERNAME%\dotfiles


:::: mklink app's settings ::::
:: dotfiles 上の各設定ファイルを同期するためのシンボリックリンク設定。

:: PowerShell エイリアス設定ファイル
mklink %USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 %USERPROFILE%\dotfiles\.config\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

:: VSCode 設定ファイル
mklink %USERPROFILE%\AppData\Roaming\Code\User\settings.json %USERPROFILE%\dotfiles\.config\Code\User\settings.json
mklink %USERPROFILE%\AppData\Roaming\Code\User\keybindings.json %USERPROFILE%\dotfiles\.config\Code\User\keybindings.json

:: Azure Data Studio 設定ファイル
mklink %USERPROFILE%\AppData\Roaming\azuredatastudio\User\settings.json %USERPROFILE%\dotfiles\.config\azuredatastudio\User\settings.json

:: Git Bash
mklink %USERPROFILE%\.bashrc %USERPROFILE%\dotfiles\.bashrc
