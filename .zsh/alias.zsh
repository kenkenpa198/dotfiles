##### Linux Command #####
alias src="source ~/.zshrc"
alias la="ls -la"
alias ll="ls -la"
alias lg="ls -la | grep"
alias h="history"
alias hg="history | grep"
alias ip="ip a | grep eth0 | grep inet | clip.exe" # WSL2 の IP アドレスを取得 & クリップボードへ格納


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
# alias vmk="sudo python3 -m venv --without-pip .venv" # システムの py を使う場合はこちら
alias va="source .venv/bin/activate"                   # 仮想環境の有効化
alias vd="deactivate"                                  # 仮想環境の無効化
alias vrm="rm -r .venv"                                # 仮想環境の削除


##### Docker #####
# Dcoker そのものを起動 / 停止するコマンド
# 起動時には Azure Data Studio 空の接続用に WSL2 の IP アドレスもクリップボードへ格納する
alias dst="sudo service docker status"
alias dsta="sudo service docker start ; sudo service docker status"
alias dsto="sudo service docker stop ; sudo service docker status"

# Docker コマンド
alias d="docker"
alias drn="docker rmi $(docker images -f 'dangling=true' -q)"

# Docker Compose コマンド
alias dc="docker-compose"
alias dcu="docker-compose up"
alias dcud="docker-compose up -d"
alias dcub="docker-compose up --build"
alias dcs="docker-compose stop"
alias dcd="docker-compose down"


##### Git #####
alias g="git"
alias gs="git status"
alias gb="git branch"
alias gsw="git switch"
alias gc="git checkout"
alias gswc="git switch -c"
alias gcm="git commit -m"
alias gg="git grep"
alias ga="git add"
alias gaa="git add -A"
alias gr="git restore"
alias gd="git diff"
alias gm="git merge"
alias gss="git status -s"
alias gp="git push"
alias gpo="git push origin"
alias gpoh="git push origin HEAD"
alias gf="git fetch"
alias gpl="git pull"
alias gl="git log"
alias gll="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gst="git stash"
alias gsts="git stash save"
alias gstp="git stash pop"


##### Apps #####
alias c="code"
alias gg="python3 $USERPROFILE/Documents/Works/Develop/GuruGuruGrep/GGGrep.py"
alias ggr="python3 $USERPROFILE/Documents/Works/Develop/GuruGuruGrep/GGGrep.py -r"
alias cl="clip.exe"
alias clip="clip.exe"


##### 環境ごとの読込 #####
case ${OSTYPE} in
    darwin*)
        # MacOS 向け設定

        ;;
    linux*)
        # Linux 向け設定

        if uname -r | grep -i 'microsoft' > /dev/null ; then
            # echo 'for WSL'
            # WSL 向け設定
            alias cdc="cd $USERPROFILE"
            alias cdd="cd $USERPROFILE/Documents/Works/Develop"
            alias ex="explorer.exe"

        fi
        ;;
esac