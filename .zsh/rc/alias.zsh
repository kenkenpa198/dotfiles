##### Linux #####
# alias
alias a="alias"
alias ag="alias | grep"
alias ac="cat ~/dotfiles/.zsh/rc/alias.zsh"         # alias を cat で確認（コメント付き）
alias acg="cat ~/dotfiles/.zsh/rc/alias.zsh | grep" # ↑を grep で

# clear
alias c="clear"

# date
alias date="date +'%Y-%m-%d (%a) %H:%M:%S'" # 現在日時をフォーマットして表示
alias dt="date"                             # 現在日時をフォーマットして表示
alias dtd="date -d"                         # 日付計算オプション
# 現在日から3日後: > dtd '3 days'
# 指定日から3日前: > dtd '2022-02-02 -3 days'

# CST to JST
# CST（日本標準時）と JST（米国中部標準時）を出力・計算する関数
# サマータイム等は考慮無しで時差を 15h として計算する

# cj               : 現在の CST と JST を表示する
# cj -c '日付時間' : 与えられた日付時間を CST とした場合の JST を出力する
# cj -j '日付時間' : 与えられた日付時間を JST とした場合の CST を出力する
# cj --help        : コマンド一覧を表示する

cj() {

    # 引数が無ければ現在の UTC から CST と UTC を計算する
    if [ $# = 0 ]; then

        # 現在の UTC 日時を取得
        utc_dt=`date -u`

        # UTC から CST を計算
        cst_dt=`date -d "${utc_dt} 6 hours ago"`

        # UTC から JST を計算
        jst_dt=`date -d "${utc_dt} 9 hours"`

        # 出力用の表示を設定
        display_msg="Display current CST and JST."
        cst_mark=" "
        jst_mark=" "

    # -c 引数を受け取った場合は第2引数を CST として JST を計算する
    elif [ $1 = "-c" ] && [ $# = 2 ]; then

        # 与えられた日付をフォーマットして CST として格納
        cst_dt=`date -d "${2}"`

        # CST から JST を計算
        jst_dt=`date -d "${cst_dt} 15 hours"`

        # 出力用の表示を設定
        display_msg="Converted CST to JST."
        cst_mark="*"
        jst_mark=" "

    # -j 引数を受け取った場合は第2引数を JST として CST を計算する
    elif [ $1 = "-j" ] && [ $# = 2 ]; then

        # 与えられた日付をフォーマットして JST として格納
        jst_dt=`date -d "${2}"`

        # JST から CST を計算
        cst_dt=`date -d "${jst_dt} 15 hours ago"`

        # 出力用の表示を設定
        display_msg="Converted JST to CST."
        cst_mark=" "
        jst_mark="*"

    # --help -h の場合はコマンド一覧を表示して終了
    elif [ $1 = "--help" ] || [ $1 = "-h" ]; then

        echo "----------------------------------------------------------------------"
        echo "                              CST to JST"
        echo "----------------------------------------------------------------------"
        echo "CST（米国中部標準時）と JST（日本標準時）を表示します。"
        echo "時差は 15h として計算します。"
        echo
        echo "  引数なし      : 現在の CST と JST を表示します。"
        echo "  -c "\'"datetime"\'" : 指定日時を CST として JST を計算します（CST - 15h）。"
        echo "  -j "\'"datetime"\'" : 指定日時を JST として CST を計算します（JST + 15h）。"
        echo "  --help        : コマンド一覧を表示します。"
        return

    # 引数指定に当てはまらなかったらエラー文を表示して終了
    else
        echo "引数を受け取れませんでした。"
        echo "使い方を確認するには "\'"cj --help"\'" を送信してください。"
        return
    fi

    # 結果の出力
    echo "${display_msg}"
    echo "--------------------------------"
    echo "${cst_mark} CST: ${cst_dt}"
    echo "${jst_mark} JST: ${jst_dt}"
}


# grep
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# history
alias h="history"
alias hg="history | grep"

# source
alias s="source"
alias ss="source ~/.zshrc"

# confirm
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"


##### dotfiles #####
alias dot="cd ~/dotfiles"
alias dotv="cd ~/dotfiles && vim ~/dotfiles"
alias dotc="cd ~/dotfiles && code ~/dotfiles"


##### zsh #####
# zmv
alias zmvnw="noglob zmv -nW" # 置換プレビュー
alias zmvw="noglob zmv -W"   # 置換


##### Git #####
alias g="git"
alias ga="git add -v"              # -v         / add の内容を表示する
alias gaa="git add -Av"            # -A         / 変更のあるファイルをすべてステージングする
alias gb="git branch"
alias gc="git checkout"
alias gcm="git commit -m"
alias gd="git diff"
alias gds="git diff --stat"        # --stat     / diff のあるファイル名のみを表示
alias gf="git fetch"
alias gl="git log"
alias gll="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" # ログを見やすい形で出力（https://prograshi.com/general/git/how-to-use-c-in-pretty-format/）
alias gm="git merge"
alias gr="git restore"
alias grs="git restore --staged ." # --staged . / ステージングをすべて元に戻す
alias gp="git push"
alias gpl="git pull"
alias gpo="git push origin"
alias gpoh="git push origin HEAD"
alias gs="git status"
alias gss="git status -s"          # -s         / 短縮表示
alias gst="git stash"
alias gstp="git stash pop"
alias gsts="git stash save"
alias gsw="git switch"
alias gswc="git switch -c"         # -c         / ブランチを作成する


##### Docker #####
# Dcoker アプリ立ち上げ
alias dst="sudo service docker status"                              # Docker の起動状況を確認
alias dsta="sudo service docker start ; sudo service docker status" # Docker を起動
alias dsto="sudo service docker stop ; sudo service docker status"  # Docker を停止

# Docker コマンド
alias d="docker"
alias drmn="docker rmi $(docker images -f 'dangling=true' -q)" # None なイメージを一括削除（https://suin.io/537）

# Docker Compose コマンド
alias dc="docker-compose"
alias dcu="docker-compose up"          # up    / コンテナを立ち上げ
alias dcud="docker-compose up -d"      # d     / バックグラウンドで立ち上げ
alias dcub="docker-compose up --build" # build / キャッシュを使わずにビルドして立ち上げ
alias dcs="docker-compose stop"        # stop  / コンテナを停止
alias dcd="docker-compose down"        # down  / コンテナを削除


##### venv #####
alias vmk="python3 -m venv .venv"                      # カレントディレクトリへ仮想環境を作成
alias vmks="sudo python3 -m venv --without-pip .venv"  # システムの py を使う場合はこちら
alias va="source .venv/bin/activate"                   # 仮想環境の有効化
alias vd="deactivate"                                  # 仮想環境の無効化
alias vrm="rm -r .venv"                                # 仮想環境の削除


##### Apps #####
alias pg8="pwgen -c -n -y -B -1 8 8"
alias pg12="pwgen -c -n -y -B -1 12 8"
alias pg32="pwgen -c -n -y -B -1 32 8"


##### Others #####


##### 環境ごとの読込 #####
case ${OSTYPE} in

    ### Linux 向け設定 ###
    linux*)
        # ls
        alias ll="ls -lahG --file-type --color=auto --time-style=long-iso --group-directories-first"
        alias llng="ls -lahG --file-type --color=auto --time-style=long-iso"
        alias lg="ls -lahG --file-type --color=auto --time-style=long-iso | grep"

        # Ubuntu
        alias update="sudo apt update && sudo apt upgrade -y" # Ubuntu 環境のアップデート & アプリの一括アップグレード

        ### WSL 向け設定 ###
        if uname -r | grep -i 'microsoft' > /dev/null ; then
            # cd
            alias cdc="cd $USERPROFILE"
            alias cdd="cd $USERPROFILE/Works/Develop"

            # cd 'C:\Windows\path'
            cdw() {
                cd $(wslpath -u ${1})
            }

            # date & copy
            alias dts="\date +'%Y-%m-%d %H:%M:%S' | tee >(clip.exe)" # 現在日時を表示（日付～時間 / ハイフンあり） & クリップボードへ格納
            alias dtss="\date +'%Y%m%d' | tee >(clip.exe)"           # 現在日時を表示（日付のみ / ハイフンなし） & クリップボードへ格納

            # wslpath
            alias wpu="wslpath -u" # パス変換: Windows → WSL（Win のパスは '' で囲んでね）
            alias wpw="wslpath -w" # パス変換: WSL → Windows

            # Apps
            alias clip="clip.exe"
            alias open="explorer.exe"
            alias ggg="python3 $USERPROFILE/Works/Develop/GuruGuruGrep/GGGrep.py"
            alias gggr="python3 $USERPROFILE/Works/Develop/GuruGuruGrep/GGGrep.py -r"

            # ググる
            # https://osa.hatenablog.jp/entry/2020/02/24/121725
            # https://www.iplab.cs.tsukuba.ac.jp/~takakura/blog/20200715/
            gg() {
                local str opt
                # $str が値ありの場合は検索ワードを + 記号でつなぐ（AND 検索）
                if [ $# != 0 ]; then
                    for i in $*; do
                        str="${str}${str:++}${i}"
                    done
                fi
                cmd.exe /c start chrome.exe "http://www.google.co.jp/search?q=${str}"
            }

            # Others
            alias ipp="ip a | grep eth0 | grep inet | tee >(clip.exe)" # WSL2 の IP アドレスを表示 & クリップボードへ格納
            alias sshpub="cat ~/.ssh/id_rsa.pub | tee >(clip.exe)"     # 公開鍵を表示 & クリップボードへ格納
        fi
    ;;

    ### MacOS 向け設定 ###
    darwin*)
        # ls
        alias ll="ls -oaF"
        alias lg="ls -oaF | grep"

        # Homebrew
        alias b="brew"
        alias bl="brew list"
        alias bs="brew search"
        alias bi="brew info"
        alias bbd="brew bundle dump --force --file '~/dotfiles/.config/Homebrew/Brewfile'"       # Brewfile ファイルの生成
        alias bbl="brew bundle list --all --force --file '~/dotfiles/.config/Homebrew/Brewfile'" # Brewfile ファイルから一括インストール
        alias bbc="cat ~/dotfiles/.config/Homebrew/Brewfile"                                     # Brewfile ファイルの表示

        # date & copy
        alias dts="\date +'%Y-%m-%d %H:%M:%S' | tee >(pbcopy)" # 現在日時を表示 & クリップボードへ格納
        alias dtss="\date +'%Y%m%d' | tee >(pbcopy)"           # 現在日時を表示 & クリップボードへ格納

        # Others
        alias sshpub="cat ~/.ssh/id_rsa.pub | tee >(pbcopy)" # 公開鍵を表示 & クリップボードへ格納
    ;;

esac
