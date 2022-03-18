<!-- omit in toc -->
# Windows へ登録する環境変数メモ

環境変数を手動で設定するためのメモ。
環境変数永続化コマンド `SETX` も存在するが、使うと良くないそうなので手動で設定する。

## 1. 登録方法

1. スタート > `env` と入力してシステムのプロパティを開く。
2. `環境変数(N)...` ボタンをクリックする。
3. 設定していく。

## 2. 登録する値

### 2.1. Path

``` bat
:: KeM-AHKs
%USERPROFILE%\Documents\Apps\KeM-AHKs\Assets

:: Win Merge
%USERPROFILE%\AppData\Local\Programs\WinMerge

:: Sakura Editor
C:\Program Files (x86)\sakura
```
