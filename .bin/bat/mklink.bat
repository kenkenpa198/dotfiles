:: CMD を管理者権限で開いてコマンドを実行
:: <<username>> は WSL2 のユーザー名へ変更（echo $USER で調べられる）

:: PowerShell
mklink %USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 \\wsl.localhost\Ubuntu\home\<<username>>\dotfiles\.config\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

:: VSCode
mklink %USERPROFILE%\AppData\Roaming\Code\User\settings.json \\wsl.localhost\Ubuntu\home\<<username>>\dotfiles\.config\Code\User\settings.json
mklink %USERPROFILE%\AppData\Roaming\Code\User\keybindings.json \\wsl.localhost\Ubuntu\home\<<username>>\dotfiles\.config\Code\User\keybindings.json
