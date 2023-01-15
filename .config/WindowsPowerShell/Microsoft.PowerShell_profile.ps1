# PowerShell のエイリアス設定用ファイル
# 設定ファイルは $PROFILE（C:\Users\%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1）に存在する
# notepad $PROFILE を実行するとメモ帳で開ける
# なんでかコメントの直後に関数を記述すると効かなくなるので1行開けてる

# シンボリックリンクでの設定方法
# 1. PowerShell で $PROFILE を実行する
# 2. 出てきたファイルパスを確認し、「WindowsPowerShell\Microsoft.PowerShell_profile.ps1」が無いことを確認する
# 2. 「WindowsPowerShell」ディレクトリを作成する
# 3. 管理者権限で cmd を開く。
# 4. cmd で上記ディレクトリを開き、mklink.bat のコマンドを送信する

# 参考
# http://www.vwnet.jp/windows/PowerShell/2020100601/PsAlias.htm
# https://qiita.com/ikanamazu/items/5f29e09b80849a4efa58
# https://www.javadrive.jp/command/dir/index8.html


##### 基本 #####
# エイリアスを再読み込み
# 開発ディレクトリへ移動
# which コマンド（https://tex2e.github.io/blog/powershell/which）
# open コマンド（https://tex2e.github.io/blog/powershell/open）

function ss(){
    powershell.exe $PROFILE
}
function dev(){
    cd $env:USERPROFILE\Works\develop
}
function which($cmdname) {
    Get-Command $cmdname | Select-Object -ExpandProperty Definition
}
Set-Alias open Invoke-Item

##### venv #####
# 仮想環境の作成
# 仮想環境の削除
# 仮想環境の有効化
# 仮想環境の削除

function vmk(){
    python -m venv .venv
}
function vrm(){
    Remove-Item .venv -Recurse
}
Set-Alias va '.venv/Scripts/activate'
Set-Alias vd deactivate


##### Apps #####
# GGGrep

function ggg(){
    python $env:USERPROFILE\Works\develop\GuruGuruGrep\GGGrep.py $args
}
