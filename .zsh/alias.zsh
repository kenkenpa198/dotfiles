##### Linux Command #####
alias ll="ls -lahG --file-type --color=auto --time-style=long-iso --group-directories-first"
alias ldng="ls -lahG --file-type --color=auto --time-style=long-iso"
alias lg="ls -lahG --file-type --color=auto --time-style=long-iso | grep"

alias h="history"
alias hg="history | grep"

alias s="source"
alias ss="source ~/.zshrc"

# 公開鍵を取得 & クリップボードへ格納
alias pubkey="cat ~/.ssh/id_rsa.pub && cat ~/.ssh/id_rsa.pub | clip.exe && echo 'Passed to Clipboard.'"

# WSL2 の IP アドレスを取得 & クリップボードへ格納
alias ip="ip a | grep eth0 | grep inet && ip a | grep eth0 | grep inet | clip.exe && echo 'Passed to Clipboard.'"

# edit dotfiles
alias cddf="cd ~/dotfiles && code ~/dotfiles"
alias vdf="cd ~/dotfiles && vim ~/dotfiles"


##### Homebrew #####
alias b="brew"
alias bl="brew list"
alias bs="brew search"
alias bi="brew info"
alias bbd="brew bundle dump --force --file '~/dotfiles/.config/Homebrew/Brewfile'"
alias bbl="brew bundle list --all --force --file '~/dotfiles/.config/Homebrew/Brewfile'"
alias bbc="cat ~/dotfiles/.config/Homebrew/Brewfile"


##### zmv #####
alias zmvnw="noglob zmv -nW" # 置換プレビュー
alias zmvw="noglob zmv -W" # 置換


##### venv #####
alias vmk="python3 -m venv .venv"                      # カレントディレクトリへ仮想環境を作成
alias vmks="sudo python3 -m venv --without-pip .venv"  # システムの py を使う場合はこちら
alias va="source .venv/bin/activate"                   # 仮想環境の有効化
alias vd="deactivate"                                  # 仮想環境の無効化
alias vrm="rm -r .venv"                                # 仮想環境の削除


##### Docker #####
# Dcoker そのものを起動 / 停止するコマンド
alias dst="sudo service docker status"
alias dsta="sudo service docker start ; sudo service docker status"
alias dsto="sudo service docker stop ; sudo service docker status"

# Docker コマンド
alias d="docker"
alias drmn="docker rmi $(docker images -f 'dangling=true' -q)" # None なイメージを一括削除（https://suin.io/537）

# Docker Compose コマンド
alias dc="docker-compose"
alias dcu="docker-compose up"
alias dcud="docker-compose up -d"
alias dcub="docker-compose up --build"
alias dcs="docker-compose stop"
alias dcd="docker-compose down"


##### Git #####
alias g="git"
alias ga="git add"
alias gaa="git status -s && echo '-- ------------------------------------------------------------------------ Staged.' && git add -A && git status -s"
alias gb="git branch"
alias gc="git checkout"
alias gcm="git commit -m"
alias gd="git diff"
alias gf="git fetch"
alias gl="git log"
alias gll="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" # ログを見やすい形で出力
alias gm="git merge"
alias gr="git restore"
alias grs="git status -s && echo '-- ------------------------------------------------------------------------ Unstaged.' && git restore --staged . && git status -s"
alias gp="git push"
alias gpl="git pull"
alias gpo="git push origin"
alias gpoh="git push origin HEAD"
alias gs="git status"
alias gss="git status -s"
alias gst="git stash"
alias gstp="git stash pop"
alias gsts="git stash save"
alias gsw="git switch"
alias gswc="git switch -c"


##### Apps #####
alias c="code"


##### 環境ごとの読込 #####
case ${OSTYPE} in

    # MacOS 向け設定
    darwin*)

    ;;

    # Linux 向け設定
    linux*)

        # WSL 向け設定
        if uname -r | grep -i 'microsoft' > /dev/null ; then
            # cd 系
            alias cdc="cd $USERPROFILE"
            alias cdd="cd $USERPROFILE/Works/Develop"

            # アプリ系
            alias open="explorer.exe"
            alias clip="clip.exe"
            alias ggg="python3 $USERPROFILE/Works/Develop/GuruGuruGrep/GGGrep.py"
            alias gggr="python3 $USERPROFILE/Works/Develop/GuruGuruGrep/GGGrep.py -r"

            # WSL2 の zsh からググる
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


        fi
    ;;
esac
