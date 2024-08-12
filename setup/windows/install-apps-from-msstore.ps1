# エラーが発生した時点で処理を中断する
$ErrorActionPreference = 'Stop'

function main {
    # インストールするアプリケーションのハッシュテーブルを定義
    $APPS = @(
        '9NSBB9XTJW86'   # A5:SQL Mk-2
        'XPDP32QDDFL4PK' # CLIP STUDIO PAINT
        '9PGCV4V3BK4W'   # DevToys
        '9P1TBXR6QDCX'   # HyperX NGENUITY
    )

    # winget のソースを更新
    winget source update

    # Microsoft Store からインストール
    # -s                          : ソースを指定するオプション
    # --accept-source-agreements  : ソースの使用許諾契約に同意するオプション
    # --accept-package-agreements : パッケージの使用許諾契約に同意するオプション
    foreach ($app in $APPS)
    {
        winget install -s msstore $app --accept-source-agreements --accept-package-agreements
    }
}

main
