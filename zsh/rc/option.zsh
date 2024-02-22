###################################
# 補完設定
###################################
# 補完機能を読み込んで実行しておく
autoload -Uz compinit && compinit

# 小文字でも大文字のディレクトリ・ファイルを補完できるようにする
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'


###################################
# 履歴設定
###################################
# 履歴の保存先ファイル指定
HISTFILE=~/.zsh_history

# メモリに保存される履歴の件数設定
export HISTSIZE=10000

# 履歴ファイルに保存される履歴の件数設定
export SAVEHIST=10000

# 履歴系のオプション
setopt hist_reduce_blanks     # 履歴に保存するときに余分なスペースを削除する
setopt hist_expire_dups_first # 履歴を切り詰める際に、重複する最も古いイベントから消す
setopt hist_ignore_all_dups   # 履歴が重複した場合に古い履歴を削除する
setopt hist_ignore_dups       # 前回のイベントと重複する場合、履歴に保存しない
setopt hist_save_no_dups      # 履歴ファイルに書き出す際、新しいコマンドと重複する古いコマンドは切り捨てる
setopt share_history          # 全てのセッションで履歴を共有する


###################################
# 色設定
###################################
# ファイルの種類で色分け
# Mac の場合にデフォルトで色分けがされないため設定する
export CLICOLOR=1

# zsh の色設定を変更
# WSL 上の zsh から Windows 環境のファイルを開いた場合に見づらいため色設定を変更する
#
# OTHER_WRITABLE 34;42 => 01;32 ... 書き込み権限が付与されたファイルを 背景緑;文字青 から ボールド;文字緑 へ変更
# EXEC           01;32 => 01;00 ... 実行属性が設定されているファイル (WSL から見た Win 側のファイル) を ボールド;文字緑 から ボールド;文字白 へ変更
#
# 参考:
# https://www.kwbtblog.com/entry/2019/04/27/023411
# https://blue-red.ddo.jp/~ao/wiki/wiki.cgi?page=ls%A5%B3%A5%DE%A5%F3%A5%C9%A4%CE%BF%A7%A4%F2%CA%D1%B9%B9%A4%B9%A4%EB
# https://www.fulldigit.co.jp/server_env/ls_colors.html
LS_COLORS='ow=01;32:ex=01;00:';
export LS_COLORS


###################################
# その他
###################################
# zmv コマンドを読み込む
autoload -Uz zmv

# 移動したディレクトリを記録しておく
# $ cd -[Tab] で移動履歴を一覧表示する
setopt auto_pushd

# ビープ音を停止する
setopt no_beep
