########################################
# zplug
########################################

source ~/.zplug/init.zsh

# fzf
# https://zoshigayan.net/ripgrep-and-fzf-with-vim/
zplug "junegunn/fzf", \
    from:github, \
    as:command, \
    rename-to:fzf, \
    use:bin/fzf, \
    hook-build:". $ZPLUG_HOME/repos/junegunn/fzf/install --bin"

# zsh-autosuggestions
zplug "zsh-users/zsh-autosuggestions"

# Set the priority when loading
# e.g., zsh-syntax-highlighting must be loaded
# after executing compinit command and sourcing other plugins
# (If the defer tag is given 2 or above, run after compinit command)
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load
