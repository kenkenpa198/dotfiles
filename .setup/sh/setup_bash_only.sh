##### dotfiles の git clone #####
# bash のみの最低限の設定版

# 1. cd
# 2. git clone https://github.com/kenkenpa198/dotfiles.git
# 3. source ~/dotfiles/.bin/sh/setup_bash_only.sh で実行開始！

echo '\n環境のアップデート'
cd
clear
sudo apt update && sudo apt upgrade -y


echo '\nshell の設定ファイルのシンボリックリンクを配置'
cd
# bash
mkdir backup
mv .bashrc ~/backup
ln -s ~/dotfiles/.bashrc ~/
source ~/.bashrc

echo '\nsetup_bash_only.sh を完了しました'
echo '\n.bashrc を再読み込みしてください'
