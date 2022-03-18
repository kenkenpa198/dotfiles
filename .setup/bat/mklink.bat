:: CMD を管理者権限で開いてコマンドを実行する


:::: Apps ::::

:: PowerShell エイリアス設定ファイル
mklink %USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 \\wsl.localhost\Ubuntu\home\%USERNAME%\dotfiles\.config\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

:: VSCode 設定ファイル
mklink %USERPROFILE%\AppData\Roaming\Code\User\settings.json \\wsl.localhost\Ubuntu\home\%USERNAME%\dotfiles\.config\Code\User\settings.json
mklink %USERPROFILE%\AppData\Roaming\Code\User\keybindings.json \\wsl.localhost\Ubuntu\home\%USERNAME%\dotfiles\.config\Code\User\keybindings.json

:: Git Bash
:: alias.zsh を .bashrc として配置する
mklink %USERPROFILE%\.bashrc \\wsl.localhost\Ubuntu\home\%USERNAME%\dotfiles\.zsh\rc\alias.zsh
