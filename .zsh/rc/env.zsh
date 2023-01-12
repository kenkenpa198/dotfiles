### 環境変数 ###

# bin
export PATH="$PATH:$HOME/.local/bin"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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

# flyctl
export FLYCTL_INSTALL="/home/${USERNAME}/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# 自作コマンドのパス
export PATH="$PATH:$HOME/bin"


### 特定環境でのみ読み込む環境変数 ###
case ${OSTYPE} in

    ### MacOS 向け設定 ###
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

    ### Linux 向け設定 ###
    linux*)

        ### WSL 向け設定 ###
        if uname -r | grep -i 'microsoft' > /dev/null ; then
            # Win 環境の環境変数を WSL 環境へ複製
            # export PATH="$PATH:$Path"
        fi
    ;;
esac
