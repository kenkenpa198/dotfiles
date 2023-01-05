##### .zsh/rc ディレクトリ内の *.zsh を読み込む #####
ZSHHOME="${HOME}/dotfiles/.zsh/rc"

if [ -d $ZSHHOME ] && [ -r $ZSHHOME ] && [ -x $ZSHHOME ]; then
    for i in $ZSHHOME/**/*; do
        # AND 演算で通ったファイルのみを読み込む
        [[ ${i##*/} = *.zsh ]] &&     # ファイル名のみを切り出して評価
        { [ -f $i ] || [ -h $i ] } && # ファイルが ファイル または シンボリックリンク である
        [ -r $i ] &&                  # ファイルが読み取り可能である
        . $i                          # ファイルを実行
    done
fi
