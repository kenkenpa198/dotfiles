::::: Run Come here windows :::::
:: Come here windows を実行する bat ファイル
:: https://www.vector.co.jp/soft/dl/winnt/util/se507321.html

:: 0. 先に mklink でこの bat ファイルを Win 環境上から実行できるようにしておく。
:: mklink /D %USERPROFILE%\dotfiles \\wsl.localhost\Ubuntu\home\%USERNAME%\dotfiles

:: 1. Win 環境の環境変数へ Come here windows の exe ファイルがある場所の PATH を設定する。
:: 例）Path: %USERPROFILE%\Documents\Apps\chw1.01.00

:: 2. 当 bat ファイルのショートカットをスタートメニューのディレクトリに配置する。
:: %USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu

comehere -29999 -29999 29999 29999 1
