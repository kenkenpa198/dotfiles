##### dotfiles の git clone #####
# 1. cd
# 2. git clone https://github.com/kenkenpa198/dotfiles.git
# 3. source ~/dotfiles/.bin/sh/setup.sh で実行開始！


echo '\n環境のアップデート'
cd
clear
sudo apt update && sudo apt upgrade -y


echo '\nSSH キーの生成'
cd
mkdir ~/.ssh
cd .ssh
ssh-keygen -t rsa # 3回すべてエンターキー
ls -la            # id_rsa（秘密鍵）と id_rsa.pub（公開鍵）が存在するか確認


echo '\nアプリインストール'
cd

# zsh
sudo apt install zsh -y
zsh --version

# git
sudo apt install git -y
sudo add-apt-repository ppa:git-core/ppa
sudo apt upgrade -y
git --version

# tree
sudo apt install tree
tree --version

# neofetch
sudo apt install neofetch -y
neofetch --version

# Python
sudo apt install python3-pip -y
pip3 --version

# Docker
# 別ファイルへ記載


echo '\ngit 関連の設定'
cd
ln -s ~/dotfiles/.gitignore_global ~/                # .gitignore_global のシンボリックリンクを作成
ln -s ~/dotfiles/.gitconfig_shared ~/                # .gitconfig_shared のシンボリックリンクを作成
git config --global include.path ~/.gitconfig_shared  # .gitconfig へ .gitconfig_shared を外部読み込み設定


echo '\nshell の設定ファイルのシンボリックリンクを配置'
cd
# bash
mkdir ~/backup
mv .bashrc ~/backup
ln -s ~/dotfiles/.bashrc ~/

# zsh
ln -s ~/dotfiles/.zshrc ~/


echo 'zsh をデフォルトシェルにする'
echo $SHELL
chsh -s $(which zsh)

echo '\nsetup.sh を完了しました'
echo '再起動してデフォルトシェルが変わっているか確認してください: echo $SHELL'