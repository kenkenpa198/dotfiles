##### dotfiles の git clone #####
# cd
# git clone https://github.com/kenkenpa198/dotfiles.git
# cd ~/dotfiles
# source ./.bin/shell/setting.sh で実行開始！


##### 環境のアップデート #####
cd
clear
sudo apt update && sudo apt upgrade -y


##### SSH キーの生成 #####
cd
mkdir ~/.ssh
cd .ssh
ssh-keygen -t rsa # 3回すべてエンターキー
ls -la            # id_rsa（秘密鍵）と id_rsa.pub（公開鍵）が存在するか確認
# cat ~/.ssh/id_rsa.pub で確認できた公開鍵を各サービスへ登録


##### アプリインストール #####
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

# Docker


##### 環境構築 #####
# zsh をデフォルトシェルにする
echo $SHELL
chsh -s $(which zsh)
echo $SHELL # 後で再起動して確認？ 初期設定は 0 で OK


##### .zshrc #####
ln -sf ~/dotfiles/.zshrc ~/ # .zshrc のシンボリックリンクを作成


##### .git 関連の設定 #####
ln -sf ~/dotfiles/.gitignore_global ~/                # .gitignore_global のシンボリックリンクを作成
ln -sf ~/dotfiles/.gitconfig_shared ~/                # .gitconfig_shared のシンボリックリンクを作成
git config --global include.path ~/.gitconfig_shared  # .gitconfig へ .gitconfig_shared を外部読み込み設定
