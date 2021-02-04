##### Commands #####
# LINUX
alias la="ls -la"
alias ll="ls -la"

# Docker
alias d="docker"
alias d-c="docker-compose"

# Git
alias gb="git branch"
alias gc="git checkout"
alias gs="git status -s"
alias ga="git add"
alias gaa="git add -A"
alias gcm="git commit -m"
alias gm="git merge"
alias gpsh="git push"
alias gpsho="git push origin"
alias gf="git fetch"
alias gpl="git pull"
alias gl="git log"
alias glo="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# 参考：https://qiita.com/pugiemonn/items/da04a422cc7da548632e

##### Homebrew #####
alias brew="PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin brew"
# brew doctor 実行時の警告「 Homebrew 管理外の config ファイルがあると衝突するかも？」の回避
# 参考：https://qiita.com/yutoman027/items/ae11bf22bdbcd645c92a