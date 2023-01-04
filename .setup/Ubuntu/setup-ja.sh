#!/bin/sh -x

##### apt インストール #####
cd

# パッケージリストの取得・既存パッケージの更新
sudo apt update && sudo apt upgrade -y

# 日本語言語パックをインストール
sudo apt install -y language-pack-ja

# 適用
sudo update-locale LANG=ja_JP.UTF8


##### man コマンドの日本語化 #####
# 日本語版マニュアルをインストール
sudo apt install -y manpages-ja manpages-ja-dev


##### 完了メッセージを表示 #####
cat \
<< msg
setup-ja.sh の実行を完了しました。
以下の対応を行ってください。

- ホストを再起動してください。
- 各ロケール設定が ja_JP.UTF8 へ変更されていることを確認してください。
    $ locale
- man コマンドで日本語マニュアルが表示されることを確認してください。
    $ man apt
msg
