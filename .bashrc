##### .bashrc #####

# .zsh ディレクトリ内の *.zsh を読み込む
ZSHHOME="${HOME}/dotfiles/.zsh"
if [ -d $ZSHHOME -a -r $ZSHHOME -a -x $ZSHHOME ]; then
    for i in $ZSHHOME/*; do

        # zsh 専用の設定系ファイルは読み込まない
        if [ ${i##*/} = option.zsh ] || [ ${i##*/} = theme.zsh ]; then
            continue
        fi

        [[ ${i##*/} = *.zsh ]] &&
        [ \( -f $i -o -h $i \) -a -r $i ] &&
        . $i
    done
fi
