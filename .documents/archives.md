<!-- omit in toc -->
# アーカイブ.md

今はもう使ってないけど後々また使いそうなコマンドや設定を残しておくマークダウン。

## 1. 各デバイスの環境を Win 環境に集約する mklink 集集

各デバイスに作業場所が点在しているので、Win 環境に集約しようとした残骸。  
かえってわかりづらくなったのでやめた。

```bat
:::: Dirs ::::

:: マイドキュメント > Files ディレクトリ ---> iCloud Drive 上の Files ディレクトリ
mklink /D %USERPROFILE%\Documents\Files %USERPROFILE%\iCloudDrive\Documents\Files

:: ワークス > Develop ディレクトリ ---> WSL2 (Ubuntu) 環境上の Develop ディレクトリ
mklink /D %USERPROFILE%\Works\Develop \\wsl.localhost\Ubuntu\home\%USERNAME%\Works\Develop

:: ワークス > Illust ディレクトリ ---> iCloud Drive 上の Illust ディレクトリ
mklink /D %USERPROFILE%\Works\Illust %USERPROFILE%\iCloudDrive\Works\Illust

:: ビデオ > Videos_D ディレクトリ ---> D ドライブ上の Videos ディレクトリ
mklink /D %USERPROFILE%\Videos\Videos_D D:\%USERNAME%\Videos
```
