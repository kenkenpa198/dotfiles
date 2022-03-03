##### $PATH #####
# 共通で読み込む PATH


# 環境ごとに読み込む PATH
case ${OSTYPE} in

    # MacOS 向け設定
    darwin*)
        # bin_M1
        export PATH="$PATH:/opt/homebrew/bin:/opt/homebrew/sbin"

        # bin
        export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"
        # pyenv
        export PATH="$PATH:$HOME/.pyenv/shims"

        # Postgres.app
        export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"

    ;;

    # Linux 向け設定
    linux*)
        # Linuxbrew
        export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"

        # Linuxbrew の実行パス
        # pyenv の設定ファイルと競合して警告が出るのでエイリアスで指定。
        alias brew='PATH=/home/linuxbrew/.linuxbrew/bin:/bin:/home/linuxbrew/.linuxbrew/sbin:/sbin brew'

        # WSL 向け設定
        if uname -r | grep -i 'microsoft' > /dev/null ; then
            # Win 環境の環境変数を WSL 環境へ複製
            export PATH="$PATH:$Path"
        fi
    ;;
esac
