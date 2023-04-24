# PowerShell のエイリアス設定用ファイル
# 設定ファイルは $PROFILE（C:\Users\%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1）に配置する。

# 参考
# http://www.vwnet.jp/windows/PowerShell/2020100601/PsAlias.htm
# https://qiita.com/ikanamazu/items/5f29e09b80849a4efa58
# https://www.javadrive.jp/command/dir/index8.html


##### 基本 #####
# 開発ディレクトリへ移動
function dev(){
    cd $env:USERPROFILE\Works\Develop
}

# which コマンド（https://tex2e.github.io/blog/powershell/which）
function which($cmdname) {
    Get-Command $cmdname | Select-Object -ExpandProperty Definition
}

# open コマンド（https://tex2e.github.io/blog/powershell/open）
Set-Alias open Invoke-Item
Set-Alias op Invoke-Item

# ls
# 作業ディレクトリのファイル一覧をコピーする
function lc() {
    # プロセス内のエンコードを Shift-JIS へ変更する
    # デフォルトでは US-ASCII で出力してしまい文字化けするため
    # 参考: https://www.vwnet.jp/Windows/PowerShell/CharCode.htm
    $OutputEncoding = [console]::OutputEncoding

    Get-ChildItem -Name | clip.exe
}


##### venv #####
# 仮想環境の作成
function vmk(){
    python -m venv .venv
}

# 仮想環境の削除
function vrm(){
    Remove-Item .venv -Recurse
}

# 仮想環境の有効化
Set-Alias va '.venv/Scripts/activate'

# 仮想環境の削除
Set-Alias vd deactivate


##### winget #####
$WINGET_OUT_PATH = "\\wsl.localhost\Ubuntu\home\${env:USERNAME}\dotfiles\setup\Windows\winget-packages.json"

function winget-export() {
    winget export -o $WINGET_OUT_PATH
}

function winget-import() {
    winget source update
    winget import -i $WINGET_OUT_PATH --accept-package-agreements --ignore-unavailable
}
