<!-- omit in toc -->
# アーカイブ.md

今はもう使ってないけどまた使いそうなコマンドや、  
後でまとめておくつもりの設定などを書き留めておくマークダウン。

## 1. mklink 集

各デバイスに作業場所が点在しているので、Win 環境に集約しようとした残骸。  
かえってわかりづらくなったのでやめた…けどやることにした（どっち）

そのうち環境構築用としてまとめる。

```bat
:::: Dirs ::::

:: Documents > Files ディレクトリ ---> iCloud Drive 上の Documents > Files ディレクトリ
mklink /D %USERPROFILE%\Documents\Files %USERPROFILE%\iCloudDrive\Documents\Files

:: Works > Create ディレクトリ ---> iCloud Drive 上の Create ディレクトリ
mklink /D %USERPROFILE%\Works\Create %USERPROFILE%\iCloudDrive\Works\Create

:: Works > Others ディレクトリ ---> iCloud Drive 上の Others ディレクトリ
mklink /D %USERPROFILE%\Works\Others %USERPROFILE%\iCloudDrive\Works\Others

:: Works > Develop ディレクトリ ---> WSL2 (Ubuntu) 環境上の Works > Develop ディレクトリ
mklink /D %USERPROFILE%\Works\Develop \\wsl.localhost\Ubuntu\home\%USERNAME%\Works\Develop

:: Videos > Capture ディレクトリ ---> D ドライブ上の Videos > Capture ディレクトリ
mklink /D %USERPROFILE%\Videos\Capture D:\%USERNAME%\Videos\Capture

:: Win ホームディレクトリ > dotfiles ---> WSL2 環境上のホームディレクトリ > dotfiles
mklink /D %USERPROFILE%\dotfiles \\wsl.localhost\Ubuntu\home\%USERNAME%\dotfiles
```
