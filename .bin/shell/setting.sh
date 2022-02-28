##### .zshrc #####
ln -sf ~/dotfiles/.zshrc ~/ # .zshrc のシンボリックリンクを作成


##### .git 関連の設定 #####
ln -sf ~/dotfiles/.gitignore_global ~/                # .gitignore_global のシンボリックリンクを作成
ln -sf ~/dotfiles/.gitconfig_shared ~/                # .gitconfig_shared のシンボリックリンクを作成
git config --global include.path ~/.gitconfig_shared  # .gitconfig へ .gitconfig_shared を外部読み込み設定
