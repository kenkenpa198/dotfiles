#!/bin/sh -x

##### apt インストール #####
cd

# Git 公式のリポジトリを apt のリポジトリへ追加
# https://loumo.jp/archives/23149
sudo add-apt-repository -y ppa:git-core/ppa

# パッケージリストの取得・既存パッケージの更新
sudo apt update && sudo apt upgrade -y

# git
sudo apt install -y git
git --version

# GNU Compiler Collection
sudo apt install -y gcc
gcc --version

# Cppcheck
sudo apt install -y cppcheck
cppcheck --version

# neofetch
sudo apt install -y neofetch
neofetch --version

# pwgen
sudo apt install -y pwgen
pwgen --version

# Python
sudo apt install -y python3-pip
pip3 --version

# Ruby
# https://jekyllrb-ja.github.io/docs/installation/ubuntu/
sudo apt-get install ruby-full build-essential zlib1g-dev
ruby --version
gem --version

# tree
sudo apt install -y tree
tree --version

# zsh
sudo apt install -y zsh
zsh --version

# パッケージのキャッシュを削除
sudo apt autoclean -y


##### Node.js インストール #####
<< comment
apt-get で Node.js を直接インストールできるが、
古いバージョン（v10系）しかインストールできないため nvm でインストールする。

nvm のインストール確認以降がうまくいかなかった場合、再起動して nvm --version から再開する。

参考: https://docs.microsoft.com/ja-jp/windows/dev-environment/javascript/nodejs-on-wsl
comment

cd
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
nvm --version

nvm ls            # バージョン一覧を表示して N/A と表示されることを確認
nvm install --lts # Node.jsの安定版をインストール
nvm ls            # 安定バージョンが入っていることを確認


##### Ruby gem インストール #####
cd

# Jekyll
# https://jekyllrb-ja.github.io/docs/installation/ubuntu/
gem install jekyll bundler
jekyll --version


##### SSH キーの生成 #####
cd
mkdir ~/.ssh
cd ~/.ssh
ssh-keygen -t rsa # パスフレーズの保存場所・入力・確認は必要に応じて設定する
ls -la            # id_rsa（秘密鍵）と id_rsa.pub（公開鍵）が存在するか確認


##### dotfiles のシンボリックリンク設定 #####
cd

# bash
cp .bashrc .bashrc.org # バックアップのみ

# zsh
ln -s ~/dotfiles/.zshrc ~/

# bin
ln -s ~/dotfiles/.bin ~/

# Git
ln -s ~/dotfiles/.gitignore_global ~/                     # .gitignore_global のシンボリックリンクを作成
ln -s ~/dotfiles/.gitconfig_shared ~/                     # .gitconfig_shared のシンボリックリンクを作成
git config --global core.excludesfile ~/.gitignore_global # .gitconfig へ .gitconfig_global を読み込み設定
git config --global include.path ~/.gitconfig_shared      # .gitconfig へ .gitconfig_shared を外部読み込み設定


##### zsh の設定 #####
cd
chsh -s $(which zsh)


##### 完了メッセージを表示 #####
cat \
<< msg
setup.sh の実行を完了しました。
以下の対応を行ってください。

- ホストを再起動してください。
- デフォルトシェルが zsh へ変更されていることを確認してください。
    $ echo \$SHELL
- Git のユーザー名とメールアドレスを登録してください。
    $ git config --global user.name <<username>>
    $ git config --global user.email <<email address>>'
msg
