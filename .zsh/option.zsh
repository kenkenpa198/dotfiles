##### Options #####
# ビープ音停止
setopt no_beep

# 補完機能を有効にする
autoload -Uz compinit && compinit

# 小文字でも大文字のディレクトリ・ファイルを補完できるようにする
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
