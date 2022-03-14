# .zsh/rc ディレクトリ内の *.zsh を読み込む
ZSHHOME="${HOME}/dotfiles/.zsh/rc"
if [ -d $ZSHHOME -a -r $ZSHHOME -a -x $ZSHHOME ]; then
    for i in $ZSHHOME/*; do
        [[ ${i##*/} = *.zsh ]] &&
        [ \( -f $i -o -h $i \) -a -r $i ] &&
        . $i
    done
fi

# .zsh/ ディレクトリ内の .dircolors を読み込む
eval $(dircolors -b ${HOME}/dotfiles/.zsh/.dircolors)
