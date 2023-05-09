<########################################
winget で各アプリケーションをインストールする PowerShell スクリプト Microsoft Store 版。

スクリプトの実行には実行ポリシーの変更が必要。
参考 : https://qiita.com/ponsuke0531/items/4629626a3e84bcd9398f

########################################>

# エラーが発生した時点で処理を中断する
$ErrorActionPreference = 'Stop'

function main {
    # インストールするアプリケーションのハッシュテーブルを定義
    $INSTALL_APPS = @(
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

    #winget のソースを更新
    winget source update

    # Microsoft Store からインストール
    # -s                          : ソースを指定するオプション
    # --accept-source-agreements  : ソースの使用許諾契約に同意するオプション
    # --accept-package-agreements : パッケージの使用許諾契約に同意するオプション
    foreach ($app in $INSTALL_APPS)
    {
        winget install -s msstore $app --accept-source-agreements --accept-package-agreements
    }
}

main
