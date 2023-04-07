# ----------------
#    winget.ps1
# ----------------
# winget を使用して各アプリケーションをインストールする PowerShell スクリプト。

# Microsoft Store へログインしておき、管理者権限で実行する。
# ダウンロードのソースが winget と Microsoft Store 両方に存在する場合は公式推奨の方に合わせている。

# スクリプトの実行には実行ポリシーの変更が必要。
# 参考 : https://qiita.com/ponsuke0531/items/4629626a3e84bcd9398f

function main {
    # エラーが発生した時点で処理を中断する
    $ErrorActionPreference = 'Stop'


    ##### winget のソースを更新 #####
    winget source update


    ##### winget からインストール #####
    # -e   : クエリで正確な文字列を使用するオプション
    # --id : インストールをアプリケーションの ID に限定するオプション

    $get_apps_from_winget = @(
        '7zip.7zip'
        'Avidemux.Avidemux'
        'Bitwarden.Bitwarden'
        'BlenderFoundation.Blender'
        'Brave.Brave'
        'Discord.Discord'
        'Docker.DockerDesktop'
        'Elgato.4KCaptureUtility'
        'Git.Git'
        'Google.Chrome'
        'Google.Drive'
        'Lexikos.AutoHotkey'
        'LINE.LINE'
        'Logitech.OptionsPlus'
        'Microsoft.AzureDataStudio'
        'Microsoft.VisualStudioCode'
        'NickeManarin.ScreenToGif'
        'Obsidian.Obsidian'
        'OBSProject.OBSStudio'
        'RealVNC.VNCViewer'
        'SaeraSoft.CaesiumImageCompress'
        'Valve.Steam'
        'WinMerge.WinMerge'
        'WinSCP.WinSCP'
    )

    foreach ($apps in $get_apps_from_winget)
    {
        winget install -e --id $app
    }


    ##### Microsoft Store からインストール #####
    # --accept-package-agreements : 使用許諾契約に同意するオプション
    # -s msstore                  : msstore をソースとして使用するオプション

    $get_apps_from_msstore = @(
        'XPDP32QDDFL4PK' # CLIP STUDIO PAINT
        '9PGCV4V3BK4W'   # DevToys
        '9NBLGGH516XP'   # EarTrumpet
        '9P1TBXR6QDCX'   # HyperX NGENUITY
        '9PB2MZ1ZMB1S'   # iTunes
        'XP89DCGQ3K6VLD' # PowerToys
        '9PJPW5LDXLZ5'   # Python 3.10
        '9NV4BS3L1H4S'   # QuickLook
        '9PLJWWSV01LK'   # Twinkle Tray
    )

    foreach ($apps in $get_apps_from_msstore)
    {
        winget install --accept-package-agreements -s msstore $app
    }
}

main
