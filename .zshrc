##### $PATH #####
# bin
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"

# pyenv
export PATH="$PATH:$HOME/.pyenv/shims"

# Postgres.app
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"

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
