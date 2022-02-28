##### $PATH #####
# bin_M1
export PATH="$PATH:/opt/homebrew/bin:/opt/homebrew/sbin"

# bin
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"

# pyenv
export PATH="$PATH:$HOME/.pyenv/shims"

# Postgres.app
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"

##### コマンドの設定 #####
# zmv コマンドを使用可能にする
autoload -U zmv

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

            # Linuxbrew
            export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"

            # Linuxbrew の実行パス
            # pyenv の設定ファイルと競合して警告が出るのでエイリアスで指定。
            alias brew='PATH=/home/linuxbrew/.linuxbrew/bin:/bin:/home/linuxbrew/.linuxbrew/sbin:/sbin brew'
        fi

            # Win 環境の環境変数を WSL 環境へ複製
            export PATH="$PATH:$Path"
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
