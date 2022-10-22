#!/bin/sh -x

clear
cd

##### 環境のアップデート #####
echo '環境のアップデート'
sudo apt update && sudo apt upgrade -y


##### 環境を日本語化 #####
echo '環境を日本語化'
sudo apt install language-pack-ja -y
sudo update-locale LANG=ja_JP.UTF8
sudo apt install manpages-ja manpages-ja-dev -y


##### SSH キーの生成 #####
echo 'SSH キーの生成'
cd
mkdir ~/.ssh
cd .ssh
ssh-keygen -t rsa # 3回すべてエンターキー
ls -la            # id_rsa（秘密鍵）と id_rsa.pub（公開鍵）が存在するか確認


##### apt インストール #####
echo 'apt インストール'

# git
sudo apt install git -y
sudo add-apt-repository ppa:git-core/ppa
sudo apt upgrade -y
git --version

# GNU Compiler Collection
sudo apt install gcc -y
gcc --version

# GNU Compiler Collection
sudo apt install cppcheck -y
cppcheck --version

# neofetch
sudo apt install neofetch -y
neofetch --version

# nvm, Node.js
<< comment
apt で Node.js を直接インストールできるが、
古いバージョン（v10系）しかインストールできないため nvm でインストールする。

nvm のインストール確認以降がうまくいかなかったら再起動して nvm --version から再開する。

参考: https://docs.microsoft.com/ja-jp/windows/dev-environment/javascript/nodejs-on-wsl
comment

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
nvm --version

nvm ls            # バージョン一覧を表示して N/A と出ることを確認
nvm install --lts # Node.jsの安定板をインストール
nvm ls            # 安定バージョンが入っていることを確認

# pwgen
sudo apt install pwgen -y
pwgen --version

# Python
sudo apt install python3-pip -y
pip3 --version

# tree
sudo apt install tree
tree --version

# zsh
sudo apt install zsh -y
zsh --version

# 最後にパッケージキャッシュを削除
sudo apt clean -y


##### git 関連の設定 #####
echo 'git 関連の設定'

cd
ln -s ~/dotfiles/.gitignore_global ~/                     # .gitignore_global のシンボリックリンクを作成
ln -s ~/dotfiles/.gitconfig_shared ~/                     # .gitconfig_shared のシンボリックリンクを作成
git config --global core.excludesfile ~/.gitignore_global # .gitconfig へ .gitconfig_global を読み込み設定
git config --global include.path ~/.gitconfig_shared      # .gitconfig へ .gitconfig_shared を外部読み込み設定


##### shell の設定ファイルのシンボリックリンクを配置 #####
echo 'shell の設定ファイルのシンボリックリンクを配置'

cd
# bash
mkdir ~/backup
mv .bashrc ~/backup
ln -s ~/dotfiles/.bashrc ~/

# zsh
ln -s ~/dotfiles/.zshrc ~/

# bin
ln -s ~/dotfiles/.bin ~/


##### zsh の設定 #####
echo 'zsh をデフォルトシェルにする'
echo $SHELL
chsh -s $(which zsh)

echo 'setup.sh を完了しました'
echo '再起動してデフォルトシェルが変わっているか確認してください: echo $SHELL'
