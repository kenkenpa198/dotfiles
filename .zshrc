# .zsh/rc ディレクトリ内の *.zsh を読み込む
ZSHHOME="${HOME}/dotfiles/.zsh/rc"
if [ -d $ZSHHOME -a -r $ZSHHOME -a -x $ZSHHOME ]; then
    # rc 配下を読み込み
    for i in $ZSHHOME/*; do
        [[ ${i##*/} = *.zsh ]] &&
        [ \( -f $i -o -h $i \) -a -r $i ] &&
        . $i
    done

    # rc/function 配下を読み込み
    for i in $ZSHHOME/function/*; do
        [[ ${i##*/} = *.zsh ]] &&
        [ \( -f $i -o -h $i \) -a -r $i ] &&
        . $i
    done
fi

# .zsh/ ディレクトリ内の .dircolors を読み込む
eval $(dircolors -b ${HOME}/dotfiles/.zsh/.dircolors)
