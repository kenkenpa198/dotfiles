:: CMD を管理者権限で開いてコマンドを実行
:: <<home dir>> は \\wsl.localhost\Ubuntu\home\<<user_directory>> が入るよ

:: PowerShell
mklink %USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 \\wsl.localhost\Ubuntu\home\<<home dir>>\dotfiles\.config\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

:: VSCode
mklink %USERPROFILE%\AppData\Roaming\Code\User\settings.json <<home dir>>\dotfiles\.config\Code\User\settings.json
mklink %USERPROFILE%\AppData\Roaming\Code\User\keybindings.json <<home dir>>\dotfiles\.config\Code\User\keybindings.json
