# bash のみの最低限の設定版

clear

echo '\n環境のアップデート'
cd
sudo apt update && sudo apt upgrade -y


echo '\nshell の設定ファイルのシンボリックリンクを配置'

# 既存の .bashrc をバックアップ
mkdir backup
mv .bashrc ~/backup

# curl で alias.zsh を .bashrc として配置
curl https://raw.githubusercontent.com/kenkenpa198/dotfiles/main/.zsh/rc/alias.zsh > .bashrc

# .bashrc の読み込み
source ~/.bashrc

echo '\nsetup_bash_only.sh を完了しました'
