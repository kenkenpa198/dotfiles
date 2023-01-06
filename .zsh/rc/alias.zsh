##### Linux #####
# cd
alias dev="cd ~/Works/Develop"
alias dot="cd ~/dotfiles"
alias obs="cd /mnt/c/Users/${USERNAME}/Documents/Obsidian"

# clear
alias c="clear"

# curl
alias wttr="curl wttr.in/${WTTR_LOCALE}"
alias wttrs="curl 'wttr.in/${WTTR_LOCALE}?0Q'"

# date
alias dt="date +'%F %T'"    # 現在日時を yyyy-MM-dd hh:mm:ss 形式で表示
alias dts="\date +'%Y%m%d'" # 現在日時を yyyyMMdd 形式で表示

# grep
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# ls
alias ll="ls -lhG --file-type --color=auto --time-style=long-iso --group-directories-first"
alias lla="ls -lhaG --file-type --color=auto --time-style=long-iso --group-directories-first"
alias llng="ls -lhG --file-type --color=auto --time-style=long-iso"
alias llang="ls -lahG --file-type --color=auto --time-style=long-iso"
alias llnga="llang"

# seq
alias seq100="seq -w 1 100" # 001 ～ 100 を表示

# source
alias ss="source ~/.zshrc"


##### C #####
alias a="./a.out"


##### Docker #####
alias dst="sudo service docker status"                              # Docker デーモンの起動状況を確認
alias dsta="sudo service docker start ; sudo service docker status" # Docker デーモンを起動
alias dsto="sudo service docker stop ; sudo service docker status"  # Docker デーモンを停止

alias d="docker"
alias dc="docker-compose"
alias drmn="docker image prune -f" # <none> イメージを一括削除 https://codechord.com/2019/08/docker-images-none-dangling/


##### Git #####
alias gaa="git add -vA" # -v: add の内容を表示する / -A: 変更のあるファイルをすべてステージングする
alias gba="git branch -a"
alias gcm="git commit -m"
alias gd="git diff"
alias gds="git diff --stat" # --stat: diff のあるファイル名のみを表示
alias gfp="git fetch --prune"
alias gl="git log --graph"
alias gll="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" # https://prograshi.com/general/git/how-to-use-c-in-pretty-format/
alias grs="git restore --staged ." # --staged: ステージングを解除
alias gpoh="git push origin HEAD"
alias gs="git status"
alias gss="git status -s" # -s: 短縮表示
alias gsw="git switch"


##### pwgen #####
alias pg14="pwgen -c -n -y -B -1 14 8"
alias pg20="pwgen -c -n -y -B -1 20 8"


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

        # apt
        alias update="sudo apt update && \
                      sudo apt upgrade -y && \
                      sudo apt autoremove -y && \
                      sudo apt autoclean -y"

        ### WSL 向け設定 ###
        if uname -r | grep -i 'microsoft' > /dev/null ; then

            # Win 環境のホームディレクトリへ cd
            alias cdc="cd /mnt/c/Users/${USERNAME}"

            # Win 環境のパスへ cd
            # cd 'C:\Windows\path'
            cdw() {
                cd $(wslpath -u ${1})
            }

            # date & copy
            alias dt="\date +'%Y-%m-%d %H:%M:%S' | tee >(clip.exe)" # 現在日時を yyyy-MM-dd hh:mm:ss 形式で表示 & クリップボードへ格納
            alias dts="\date +'%Y%m%d' | tee >(clip.exe)"           # 現在日時を yyyyMMdd 形式で表示 & クリップボードへ格納

            # hostname & copy
            alias hi="hostname -I | tee >(clip.exe)" # ホスト（WSL 環境）の IP アドレスを表示 & クリップボードへ格納

            # seq & copy
            alias seq100="seq -w 1 100 | tee >(clip.exe)" # 001 ～ 100 を表示 & クリップボードへ格納

            # wsl
            alias shutdown="cmd.exe /c start wsl.exe '--shutdown'" # WSL をシャットダウンする

            # wslpath
            alias wpu="wslpath -u" # パス変換: Windows → WSL（Win のパスは '' で囲む）
            alias wpw="wslpath -w" # パス変換: WSL → Windows

            # Windows Apps
            alias clip="clip.exe" # '| clip' で Win 環境のクリップボードへ渡せる。例）$ echo 'neko' | clip
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

                # 既定のブラウザで URL を開く
                cmd.exe /c start "http://www.google.co.jp/search?q=${str}"
            }

        fi
    ;;

    ### MacOS 向け設定 ###
    darwin*)
        # ls
        alias ll="ls -oF"
        alias lla="ls -oaF"
        alias llg="ls -oaF | grep"

        # Homebrew
        alias bbd="brew bundle dump --force --file '~/dotfiles/.config/Homebrew/Brewfile'"       # Brewfile ファイルの生成
        alias bbl="brew bundle list --all --force --file '~/dotfiles/.config/Homebrew/Brewfile'" # Brewfile ファイルから一括インストール
        alias bbc="cat ~/dotfiles/.config/Homebrew/Brewfile"                                     # Brewfile ファイルの表示

        # date & copy
        alias dt="\date +'%Y-%m-%d %H:%M:%S' | tee >(pbcopy)" # 現在日時を yyyy-MM-dd hh:mm:ss 形式で表示 & クリップボードへ格納
        alias dts="\date +'%Y%m%d' | tee >(pbcopy)"           # 現在日時を yyyyMMdd 形式で表示 & クリップボードへ格納

        # open
        alias op="open"
    ;;

esac
