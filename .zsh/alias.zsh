##### Linux Command #####
alias src="source ~/.zshrc"
alias la="ls -la"
alias ll="ls -la"
alias ...="cd ../.."
alias ....="cd ../../.."
alias h="history"
alias hg="history | grep"


##### Docker #####
alias d="docker"
alias dc="docker-compose"

##### Git #####
alias g="git"
alias gs="git status"
alias gb="git branch"
alias gc="git checkout"
alias gcm="git commit -m"
alias gg="git grep"
alias ga="git add"
alias gaa="git add -A"
alias gd="git diff"
alias gm="git merge"
alias gss="git status -s"
alias gp="git push"
alias gpo="git push origin"
alias gpom="git push origin main"
alias gpod="git push origin develop"
alias gf="git fetch"
alias gpl="git pull"
alias gl="git log"
alias gll="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gst="git stash"
alias gsts="git stash save"
alias gstp="git stash pop"


##### Homebrew #####
# brew doctor 実行時の警告「 Homebrew 管理外の config ファイルがあると衝突するかも？」の回避
alias brew="PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin brew"
