##### Linux #####
# alias
alias a="alias"
alias ag="alias | grep"
alias ac="cat ~/dotfiles/.zsh/rc/alias.zsh"         # alias を cat で確認（コメント付き）
alias acg="cat ~/dotfiles/.zsh/rc/alias.zsh | grep" # ↑を grep で

# cd
alias cdd="cd ~/Works/Develop"
alias dev="cdd"

# clear
alias c="clear"

# date
alias dt="date +'%F (%a) %T'" # 現在日時を yyyy-MM-dd (A) hh:mm:ss 形式で表示

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


##### dotfiles #####
alias dot="cd ~/dotfiles"
alias dotv="cd ~/dotfiles && vim ~/dotfiles"
alias dotc="cd ~/dotfiles && code ~/dotfiles"


##### zsh #####
# zmv
alias zmvnw="noglob zmv -nW" # 置換プレビュー
alias zmvw="noglob zmv -W"   # 置換


##### tree #####
alias tr="tree 	--dirsfirst -I '__pycache__'"
alias tra="tree -a --dirsfirst -I '__pycache__|.venv|.git'"
alias traa="tree -a --dirsfirst"


##### Git #####
alias g="git"
alias ga="git add -v"              # -v         / add の内容を表示する
alias gaa="git add -Av"            # -A         / 変更のあるファイルをすべてステージングする
alias gb="git branch"
alias gba="git branch -a"
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
    # msys は Win 環境上で Git Bash を立ち上げたときの $OSTYPE
    linux* | msys*)
        # ls
        alias ll="ls -lhG --file-type --color=auto --time-style=long-iso --group-directories-first"
        alias lla="ls -lhaG --file-type --color=auto --time-style=long-iso --group-directories-first"
        alias llng="ls -lhG --file-type --color=auto --time-style=long-iso"
        alias llang="ls -lahG --file-type --color=auto --time-style=long-iso"
        alias llnga="llang"
        alias llg="ls -lahG --file-type --color=auto --time-style=long-iso | grep"

        # Ubuntu
        alias update="sudo apt update && sudo apt upgrade -y" # Ubuntu 環境のアップデート & アプリの一括アップグレード

        ### WSL 向け設定 ###
        if uname -r | grep -i 'microsoft' > /dev/null ; then

            # Win 環境のホームへ cd
            alias cdc="cd $USERPROFILE"

            # cd 'C:\Windows\path'
            cdw() {
                cd $(wslpath -u ${1})
            }

            # date & copy
            alias dtt="\date +'%Y-%m-%d %H:%M:%S' | tee >(clip.exe)" # 現在日時を表示（日付～時間 / ハイフンあり） & クリップボードへ格納
            alias dttt="\date +'%Y%m%d' | tee >(clip.exe)"           # 現在日時を表示（日付のみ / ハイフンなし） & クリップボードへ格納

            # wslpath
            alias wpu="wslpath -u" # パス変換: Windows → WSL（Win のパスは '' で囲んでね）
            alias wpw="wslpath -w" # パス変換: WSL → Windows

            # Apps
            alias clip="clip.exe"
            alias open="explorer.exe"
            alias op="open"
            alias notepad="notepad.exe"
            alias sakura="sakura.exe"
            alias wm="WinMergeU.exe"
            alias ggg="python3 ~/Works/Develop/GuruGuruGrep/GGGrep.py"
            alias gggr="python3 ~/Works/Develop/GuruGuruGrep/GGGrep.py -r"
            alias gdd="python3 ~/Works/Develop/GenerateDummyData/GenerateDummyData.py"

            # ググる
            # https://osa.hatenablog.jp/entry/2020/02/24/121725
            # https://www.iplab.cs.tsukuba.ac.jp/~takakura/blog/20200715/
            gg() {
                local str
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
            alias shutdown="cmd.exe /c start wsl.exe '--shutdown'"     # WSL2 をシャットダウンする
        fi
    ;;

    ### MacOS 向け設定 ###
    darwin*)
        # ls
        alias ll="ls -oF"
        alias lla="ls -oaF"
        alias llg="ls -oaF | grep"

        # Homebrew
        alias b="brew"
        alias bl="brew list"
        alias bs="brew search"
        alias bi="brew info"
        alias bbd="brew bundle dump --force --file '~/dotfiles/.config/Homebrew/Brewfile'"       # Brewfile ファイルの生成
        alias bbl="brew bundle list --all --force --file '~/dotfiles/.config/Homebrew/Brewfile'" # Brewfile ファイルから一括インストール
        alias bbc="cat ~/dotfiles/.config/Homebrew/Brewfile"                                     # Brewfile ファイルの表示

        # date & copy
        alias dtt="\date +'%Y-%m-%d %H:%M:%S' | tee >(pbcopy)" # 現在日時を表示 & クリップボードへ格納
        alias dttt="\date +'%Y%m%d' | tee >(pbcopy)"           # 現在日時を表示 & クリップボードへ格納

        # Others
        alias op="open"
        alias sshpub="cat ~/.ssh/id_rsa.pub | tee >(pbcopy)" # 公開鍵を表示 & クリップボードへ格納
    ;;

esac
