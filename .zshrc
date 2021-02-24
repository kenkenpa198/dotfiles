##### $PATH #####
# bin
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"

# pyenv
export PATH="$PATH:$HOME/.pyenv/shims"

# Postgres.app
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"


##### 環境ごとの読込 #####
case ${OSTYPE} in
    darwin*)
        # echo 'for MacOS'
        # MacOS 向け設定

        ;;
    linux*)
        # echo 'fot Linux'
        # Linux 向け設定

        if uname -r | grep -i 'microsoft' > /dev/null ; then
            # echo 'for WSL'
            # WSL 向け設定
            
            # Win 環境の環境変数を WSL 環境へ複製
            export PATH="$PATH:$Path"

            # Linuxbrew
            export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"
        fi
        ;;
esac


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
