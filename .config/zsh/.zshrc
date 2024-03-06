########################################
# bin
########################################
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"


########################################
# Sheldon
########################################
# Loading plugins with Sheldon
# https://sheldon.cli.rs/Getting-started.html
eval "$(sheldon source)"


########################################
# *.zsh の読み込み
########################################
# Sheldon が使用できない環境では下記を有効化して設定ファイルを読み込む

# # $ZSHHOME 変数を初期化
# ZSHHOME="${HOME}/dotfiles/zsh/rc"

# # $ZSHHOME がディレクトリである かつ 読込権限がある かつ 実行権限がある
# if [ -d $ZSHHOME ] && [ -r $ZSHHOME ] && [ -x $ZSHHOME ]; then
#     # $ZSHHOME 配下の *.zsh ファイルに対して再帰的に処理
#     for i in $ZSHHOME/**/*; do
#         # AND 演算で通ったファイルのみを読み込む
#         [[ ${i##*/} = *.zsh ]] &&     # ファイル名が ***.zsh である
#         { [ -f $i ] || [ -h $i ] } && # ファイルが ファイル または シンボリックリンク である
#         [ -r $i ] &&                  # ファイルに読込権限がある
#         . $i                          # ファイルを実行する
#     done
# fi
