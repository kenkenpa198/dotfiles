###################################
# autoload
###################################
# zmv コマンドを読み込む
autoload -Uz zmv

# 補完機能の読み込みと実行
autoload -Uz compinit && compinit


###################################
# autoload
###################################
# 履歴の保存先ファイル指定
export HISTFILE=$XDG_STATE_HOME/zsh/history

# メモリに保存される履歴の件数設定
export HISTSIZE=10000

# 履歴ファイルに保存される履歴の件数設定
export SAVEHIST=10000


###################################
# setopt
###################################
# 履歴系のオプション
setopt hist_reduce_blanks     # 履歴に保存するときに余分なスペースを削除する
setopt hist_expire_dups_first # 履歴を切り詰める際に、重複する最も古いイベントから消す
setopt hist_ignore_all_dups   # 履歴が重複した場合に古い履歴を削除する
setopt hist_ignore_dups       # 前回のイベントと重複する場合、履歴に保存しない
setopt hist_save_no_dups      # 履歴ファイルに書き出す際、新しいコマンドと重複する古いコマンドは切り捨てる
setopt share_history          # 全てのセッションで履歴を共有する

# 移動したディレクトリを記録しておく
# $ cd -[Tab] で移動履歴を一覧表示する
setopt auto_pushd

# ビープ音を停止する
setopt no_beep


###################################
# zstyle
###################################
# https://qiita.com/minnsou/items/3e9f200f9f2cc9a92920

# 小文字でも大文字のディレクトリ・ファイルを補完できるようにする
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 近似補完を有効にする
zstyle ':completion:*' completer _complete _approximate

# 補完一覧のカーソル選択
# zstyle ':completion:*' menu select

# rm の引数の時にはメニュー補完をしない
# zstyle ':completion:*:rm:*' menu false

# 補完時の色設定
# zstyle ':completion:*:default' list-colors di=4
