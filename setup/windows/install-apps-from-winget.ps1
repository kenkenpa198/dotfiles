# エラーが発生した時点で処理を中断する
$ErrorActionPreference = 'Stop'

function main {
    # インストールするアプリケーションのハッシュテーブルを定義
    $APPS = @(
        '7zip.7zip'
        'Apple.iTunes'
        'AutoHotkey.AutoHotkey'
        'Avidemux.Avidemux'
        'Bitwarden.Bitwarden'
        'BlenderFoundation.Blender'
        'Brave.Brave'
        'Discord.Discord'
        'Docker.DockerDesktop'
        'Elgato.4KCaptureUtility'
        'Mozilla.Firefox'
        'Git.Git'
        'Google.Chrome'
        'Google.GoogleDrive'
        'LINE.LINE'
        'Logitech.OptionsPlus'
        'Microsoft.AzureDataStudio'
        'Microsoft.PowerToys'
        'Microsoft.VisualStudio.2022.Community'
        'Microsoft.VisualStudioCode'
        'nepnep.neofetch-win'
        'NickeManarin.ScreenToGif'
        'Postman.Postman'
        'Obsidian.Obsidian'
        'OBSProject.OBSStudio'
        'Oracle.VirtualBox'
        'QL-Win.QuickLook'
        'RealVNC.VNCViewer'
        'SaeraSoft.CaesiumImageCompress'
        'Unity.UnityHub'
        'Valve.Steam'
        'Wacom.WacomTabletDriver'
        'WinMerge.WinMerge'
        'WinSCP.WinSCP'
        'xanderfrangos.twinkletray'
    )

    # winget のソースを更新
    winget source update

    # winget リポジトリからインストール
    # -s                          : ソースを指定するオプション
    # -e                          : クエリで正確な文字列を使用するオプション
    # --id                        : インストールをアプリケーションの ID に限定するオプション
    # --accept-source-agreements  : ソースの使用許諾契約に同意するオプション
    # --accept-package-agreements : パッケージの使用許諾契約に同意するオプション
    foreach ($app in $APPS)
    {
        winget install -s winget -e --id $app --accept-source-agreements --accept-package-agreements
    }
}

main
