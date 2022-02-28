# PowerShell のエイリアス設定用ファイル
# 設定ファイルは $PROFILE（C:\Users\%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1）に配置する
# notepad $PROFILE を実行するとメモ帳で開ける

# 【1】直接作成する場合
# 1. PowerShell で $PROFILE を実行する
# 2. 出てきたファイルパスを確認し、「WindowsPowerShell\Microsoft.PowerShell_profile.ps1」が無ければ作成する
# 3. notepad $PROFILE でメモ帳で起動する
# 4. このエイリアス設定を転記する

# 【2】シンボリックリンクを作成する場合
# 1. 上の操作で「WindowsPowerShell\Microsoft.PowerShell_profile.ps1」が無いことを確認する
# 2. 「WindowsPowerShell」ディレクトリを作成する
# 3. 管理者権限で cmd を開く。
# 4. cmd で上記ディレクトリを開き、下記のコマンドを送信する
# mklink Microsoft.PowerShell_profile.ps1 \\wsl.localhost\Ubuntu\home\<<home dir>>\dotfiles\.config\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

# 参考
# http://www.vwnet.jp/windows/PowerShell/2020100601/PsAlias.htm
# https://qiita.com/ikanamazu/items/5f29e09b80849a4efa58
# https://www.javadrive.jp/command/dir/index8.html

# GGGrep を起動

function gg(){
    python3 $env:USERPROFILE\Documents\Works\Develop\GuruGuruGrep\GGGrep.py $args
}
