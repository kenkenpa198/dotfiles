# ------------------
#    get-apps.ps1
# ------------------
# アプリケーションやそのインストーラーを curl.exe でダウンロードする PowerShell スクリプト。
# winget のソースに登録がないアプリケーションはこちらをつかってインストールする。
# ユーザーのダウンロードフォルダへ保存される。

# TODO: 最新バージョンを取得できるようにしたい


##### ユーザーのダウンロードフォルダへ移動 #####
cd ~\Downloads


##### アプリケーション #####
# Change Key
# https://forest.watch.impress.co.jp/library/software/changekey/
curl.exe -OL https://dforest.watch.impress.co.jp/library/c/changekey/10668/ChgKey15.LZH

# alt-ime-ahk
# https://github.com/karakaram/alt-ime-ahk/releases
curl.exe -OL https://github.com/karakaram/alt-ime-ahk/releases/download/v0.4.6/alt-ime-ahk.zip

# サクラエディタ
# https://github.com/sakura-editor/sakura/releases
curl.exe -OL https://github.com/sakura-editor/sakura/releases/download/v2.4.2/sakura-tag-v2.4.2-build4203-a3e63915b-Win32-Release-Installer.zip

# Free Video Compressor
# https://www.gigafree.net/media/me/FreeVideoCompressor.html
curl.exe -OL http://file1.softsea.com/download/9a21a475/581d90138b5eb64e91f75495e3a359b7/Video_Utility/freevideocompressor_setup.exe


##### ドライバー #####
# Wacom driver
# https://tablet.wacom.co.jp/download/
curl.exe -OL https://tablet.wacom.co.jp/download/driver/WacomTablet_6.4.0-11.exe


##### フォント #####
# HackGen
# https://github.com/yuru7/HackGen/releases
curl.exe -OL https://github.com/yuru7/HackGen/releases/download/v2.8.0/HackGen_v2.8.0.zip

# Noto Sans Japanese
# https://fonts.google.com/noto/specimen/Noto+Sans+JP
curl.exe -OL https://fonts.google.com/download?family=Noto%20Sans%20JP


##### 手動インストール #####
# 以下は利用規約の許諾操作によりダウンロードの自動化が難しかったり、環境構築に必須ではないアプリケーション。
# 必要に応じてインストールする。

# DaVinci Resolve / https://www.blackmagicdesign.com/jp/products/davinciresolve
# Vroid Studio / https://vroid.com/
# 3tene / https://3tene.com/
# Valorant / https://playvalorant.com/ja-jp/download/
# RictyDiminished-for-Powerline / https://github.com/mzyy94/RictyDiminished-for-Powerline
