##### Options #####
# ビープ音停止
setopt no_beep

# 補完機能を有効にする
autoload -Uz compinit && compinit

# 小文字でも大文字のディレクトリ・ファイルを補完できるようにする
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# zmv コマンドを使用可能にする
autoload -U zmv

# 移動したディレクトリを記録しておく。"cd -[Tab]"で移動履歴を一覧表示
setopt auto_pushd