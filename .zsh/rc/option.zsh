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

# 履歴の保存先ファイル指定
HISTFILE=~/.zsh_history

# メモリに保存される履歴の件数を設定
export HISTSIZE=100

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=4000

# 同時に起動しているzshの間で history を共有する
setopt share_history

# history に保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 同じコマンドを history に残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンドを history に残さない
setopt hist_ignore_space