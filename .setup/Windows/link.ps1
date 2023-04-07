# --------------
#    link.ps1
# --------------
# シンボリックリンク作成用 PowerShell スクリプト。
# クラウド環境や WSL 環境のディレクトリ・設定ファイルを Win 環境から利用できるようにする。
# WSL2 のディレクトリ上にある bat ファイルを Win 側から実行する場合、このシンボリックリンク設定を行った上で Win 側からその bat ファイルを実行したりショートカットを作成する。

# 参考:
# [PowerShellで苦労して作るシンボリックリンク - Qiita](https://qiita.com/tokky_se/items/128a04e861b2863e2c99)
# [Googleドライブのパスを英語に変更したい - 日日是好日](https://siromiuo.hateblo.jp/entry/2021/11/03/133144)
# [PowerShellの配列と連想配列 | 晴耕雨読](https://tex2e.github.io/blog/powershell/array)
# [PowerShellでのシンボリックリンク判定について](https://teratail.com/questions/184340)
# [ハッシュテーブルについて知りたかったことのすべて - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/scripting/learn/deep-dives/everything-about-hashtable?view=powershell-7.3)


function main {
    ##### 連想配列を宣言 #####
    $linkHash = [ordered]@{}

    # 下記の記述で挿入する。
    # $linkHash['原本ファイルのパス'] = 'シンボリックリンクのパス'


    ##### Win 環境 => クラウドストレージ #####
    # Files
    $linkHash['~\GoogleDrive\Documents\Files'] = '~\Documents\Files'

    # Works
    $linkHash['~\GoogleDrive\Works\Create']    = '~\Works\Create'
    $linkHash['~\GoogleDrive\Works\Notes']     = '~\Works\Notes'
    $linkHash['~\GoogleDrive\Works\Others']    = '~\Works\Others'


    ##### Win 環境 => WSL 環境 #####
    # WSL 側のホームディレクトリパスを初期化
    $WSLHOME = "\\wsl.localhost\Ubuntu\home\${env:USERNAME}"

    # Develop
    $linkHash["${WSLHOME}\works\develop"] = '~\Works\Develop'

    # PowerShell エイリアス設定ファイル
    $linkHash["${WSLHOME}\dotfiles\.config\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"] = '~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1'

    # VSCode 設定ファイル
    $linkHash["${WSLHOME}\dotfiles\.config\Code\User\settings.json"]    = '~\AppData\Roaming\Code\User\settings.json'
    $linkHash["${WSLHOME}\dotfiles\.config\Code\User\keybindings.json"] = '~\AppData\Roaming\Code\User\keybindings.json'

    # Azure Data Studio 設定ファイル
    $linkHash["${WSLHOME}\dotfiles\.config\azuredatastudio\User\settings.json"] = '~\AppData\Roaming\azuredatastudio\User\settings.json'

    # Git Bash .bashrc
    $linkHash["${WSLHOME}\.bashrc"] = '~\.bashrc'


    ##### その他 #####
    # [Win] ~\Videos\Capture ---> [D ドライブ] ~\Videos\Capture
    $linkHash["D:\${env:USERNAME}\Videos\Capture"] = '~\Videos\Capture'


    ##### シンボリックリンクを作成 #####
    foreach ($key in $linkHash.Keys) {
        # 連想配列のキーを原本ファイルパスとして初期化
        $originPath = $key

        # 連想配列の値をリンク先のパス、ディレクトリパス、リンク名として初期化
        $linkPath = $($linkHash[$key])
        $linkDir  = Split-Path -Path $($linkHash[$key]) -Parent
        $linkName = Split-Path -Path $($linkHash[$key]) -Leaf

        # 原本ファイルパスが存在しなかったらループをスキップする
        if (!(Test-Path $originPath)) {
            Write-Host "$originPath is not found. Skip this loop."
            continue
        }

        # 作成先へリンクアイテムが存在していたらループをスキップする
        if ((Test-Path $linkPath) -and (Get-ItemProperty $linkPath).Mode.Substring(5, 1) -eq 'l') {
            Write-Host "$linkPath is linked. Skip this loop."
            continue
        }

        # 作成先へリンク以外のアイテムが存在していたらバックアップする
        if (Test-Path $linkPath) {
            $linkPathBackup = $linkPath + '.org'

            Write-Host "$linkPath is found. Make backup file to $linkPathBackup ."
            Move-Item $linkPath $linkPathBackup

            # FIXME:
            # バックアップ処理には Copy-Item ではなく Move-Item を使用している。
            # Copy-Item でバックアップ対象のファイルを複製後にシンボリックリンクで上書きする処理工程にしたかったが、
            # New-Item は -Force オプションでディレクトリを上書きできないようなため。
        }

        # シンボリックリンクを作成
        New-Item -Value $originPath -Path $linkDir -Name $linkName -ItemType SymbolicLink -Force
        Write-Host "Finished link $originPath to $linkPath ."
    }
}

main
