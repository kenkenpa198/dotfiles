########################################
# gcloud
########################################
# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi


########################################
# nvm
########################################
# https://github.com/nvm-sh/nvm?tab=readme-ov-file#git-install
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


########################################
# pyenv
########################################
# https://github.com/pyenv/pyenv?tab=readme-ov-file#set-up-your-shell-environment-for-pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


########################################
# rbenv
########################################
# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"


########################################
# sheldon
########################################
# https://sheldon.cli.rs/Getting-started.html

# fzf
export FZF_DEFAULT_OPTS="--height 80% --reverse --border"

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=243"


########################################
# Load by environment
########################################
case ${OSTYPE} in
    # for Linux
    linux*)
        # for WSL
        if uname -r | grep -i 'microsoft' > /dev/null ; then
            # Win 環境の環境変数を WSL 環境へ複製
            # export PATH="$PATH:$Path"
        fi
    ;;

    # for MacOS
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
