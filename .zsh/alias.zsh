##### Linux Command #####
alias src="source ~/.zshrc"
alias la="ls -la"
alias ll="ls -la"
alias lg="ls -la | grep"
alias h="history"
alias hg="history | grep"


##### Homebrew #####
alias b="brew"
alias bl="brew list"
alias bs="brew search"
alias bi="brew info"
alias bbd="brew bundle dump --force --file '~/dotfiles/.config/Homebrew/Brewfile'"
alias bbl="brew bundle list --all --force --file '~/dotfiles/.config/Homebrew/Brewfile'"
alias bbc="cat ~/dotfiles/.config/Homebrew/Brewfile"


##### Docker #####
alias d="docker"
alias drn="docker rmi $(docker images -f 'dangling=true' -q)"

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
alias gpoh="git push origin HEAD"
alias gf="git fetch"
alias gpl="git pull"
alias gl="git log"
alias gll="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gst="git stash"
alias gsts="git stash save"
alias gstp="git stash pop"


##### Apps #####
alias v="vim"
alias e="emacs"
alias c="code"
