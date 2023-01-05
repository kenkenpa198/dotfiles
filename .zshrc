##### .zsh/rc ディレクトリ内の *.zsh を読み込む #####
ZSHHOME="${HOME}/dotfiles/.zsh/rc"

if [ -d $ZSHHOME -a -r $ZSHHOME -a -x $ZSHHOME ]; then
    for i in $ZSHHOME/**/*; do
        # AND 演算で通ったファイルのみを読み込む
        [[ ${i##*/} = *.zsh ]] &&            # ファイル名のみを切り出して評価
        [ \( -f $i -o -h $i \) -a -r $i ] && # (ファイル または シンボリックリンク) かつ 読み取り可能
        . $i                                 # 実行
    done
fi
