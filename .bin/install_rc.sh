##### install dotfiles to VSCode Remote Containers #####
echo "===== dotfiles の読込を開始します ====="

#!/bin/zsh
ln -fs ~/dotfiles/.zshrc ~/

source .zshrc

echo "===== dotfiles の読込を完了しました ====="