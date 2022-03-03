##### .zsh ディレクトリ内ファイルの読み込み #####
# .zsh ディレクトリ内の *.zsh を読み込む
ZSHHOME="${HOME}/dotfiles/.zsh"
if [ -d $ZSHHOME -a -r $ZSHHOME -a \
     -x $ZSHHOME ]; then
    for i in $ZSHHOME/*; do
        [[ ${i##*/} = *.zsh ]] &&
            [ \( -f $i -o -h $i \) -a -r $i ] && . $i
    done
fi
