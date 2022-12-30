##### Linux Commands #####
# cd
alias dev="cd ~/Works/Develop"
alias dot="cd ~/dotfiles"

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


##### C #####
alias a="./a.out"


##### curl #####
alias wttr="curl wttr.in/${WTTR_LOCALE}"
alias wttrs="curl 'wttr.in/${WTTR_LOCALE}?0Q'"


##### Docker #####
alias dst="sudo service docker status"                              # Docker の起動状況を確認
alias dsta="sudo service docker start ; sudo service docker status" # Docker を起動
alias dsto="sudo service docker stop ; sudo service docker status"  # Docker を停止

alias d="docker"
alias dc="docker-compose"
alias drmn="docker image prune -f" # <none> イメージを一括削除 https://codechord.com/2019/08/docker-images-none-dangling/


##### Git #####
alias ga="git add -v" # -v / add の内容を表示する
alias gaa="git add -Av" # -A / 変更のあるファイルをすべてステージングする
alias gb="git branch"
alias gba="git branch -a"
alias gc="git checkout"
alias gcm="git commit -m"
alias gd="git diff"
alias gds="git diff --stat" # --stat / diff のあるファイル名のみを表示
alias gf="git fetch"
alias gfp="git fetch --prune"
alias gl="git log --graph"
alias gll="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" # ログを見やすい形で出力（https://prograshi.com/general/git/how-to-use-c-in-pretty-format/）
alias gr="git restore"
alias grs="git restore --staged ." # --staged . / ステージングをすべて元に戻す
alias gpoh="git push origin HEAD"
alias gs="git status"
alias gss="git status -s" # -s / 短縮表示
alias gsw="git switch"


##### pwgen #####
alias pg8="pwgen -c -n -y -B -1 8 8"
alias pg12="pwgen -c -n -y -B -1 12 8"
alias pg32="pwgen -c -n -y -B -1 32 8"


##### tree #####
alias tr="tree 	--dirsfirst -I '__pycache__'"               # 隠しファイル以外を表示
alias tra="tree -a --dirsfirst -I '__pycache__|.venv|.git'" # 隠しファイルを含めて表示（設定系のファイルは除外）
alias traa="tree -a --dirsfirst"                            # とにかくすべて表示


##### venv #####
alias vmk="python3 -m venv .venv"                      # カレントディレクトリへ仮想環境を作成
alias vmks="sudo python3 -m venv --without-pip .venv"  # システムの py を使う場合はこちら
alias va="source .venv/bin/activate"                   # 仮想環境の有効化
alias vd="deactivate"                                  # 仮想環境の無効化
alias vrm="rm -r .venv"                                # 仮想環境の削除


##### zsh #####
# zmv
alias zmvnw="noglob zmv -nW" # 置換プレビュー
alias zmvw="noglob zmv -W"   # 置換


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
            alias cdc="cd /mnt/c/Users/${USERNAME}"

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
            alias opr="open README.md"

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
            alias ipc="hostname -I | tee >(clip.exe)" # WSL2 の IP アドレスを表示 & クリップボードへ格納
            alias shutdown="cmd.exe /c start wsl.exe '--shutdown'" # WSL2 をシャットダウンする
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
