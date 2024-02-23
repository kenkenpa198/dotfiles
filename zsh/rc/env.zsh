########################################
# 環境変数
########################################
# bin
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# nvm lazy-load
# https://izumisy.work/entry/2020/05/23/213107
if [ -s "$NVM_DIR/nvm.sh" ]; then
    alias nvm='unalias nvm node npm && \. "$NVM_DIR/nvm.sh" && nvm'
    alias node='unalias nvm node npm && \. "$NVM_DIR/nvm.sh" && node'
    alias npm='unalias nvm node npm && \. "$NVM_DIR/nvm.sh" && npm'
fi
# gcloud
# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# ruby
# Install Ruby Gems to ~/gems
# http://jekyllrb-ja.github.io/docs/installation/ubuntu/
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init - zsh)"

# rbenv lazy-load
if [ -s "$HOME/.rbenv" ]; then
  alias ruby='unalias ruby bundle gem && eval "$(rbenv init - zsh)" && ruby'
  alias bundle='unalias ruby bundle gem && eval "$(rbenv init - zsh)" && bundle'
  alias gem='unalias ruby bundle gem && eval "$(rbenv init - zsh)" && gem'
fi
# flyctl
export FLYCTL_INSTALL="/home/${USERNAME}/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# sheldon
# https://sheldon.cli.rs/Getting-started.html
eval "$(sheldon source)"

# fzf
export FZF_DEFAULT_OPTS="--height 80% --reverse --border"

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=243"


########################################
# 環境ごとの読込
########################################
case ${OSTYPE} in
    # Linux 向け設定
    linux*)
        # WSL
        if uname -r | grep -i 'microsoft' > /dev/null ; then
            # Win 環境の環境変数を WSL 環境へ複製
            # export PATH="$PATH:$Path"
        fi
    ;;

    # MacOS
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
esac
