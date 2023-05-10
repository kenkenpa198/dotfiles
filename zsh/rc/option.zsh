###################################
# 補完設定
###################################
# 補完機能を有効にして実行しておく
autoload -Uz compinit && compinit

# 小文字でも大文字のディレクトリ・ファイルを補完できるようにする
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'


###################################
# 履歴設定
###################################
# 履歴の保存先ファイル指定
HISTFILE=~/.zsh_history

# メモリに保存される履歴の件数を設定
export HISTSIZE=10000

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=10000

# 同時に起動している zsh の間で history を共有する
setopt share_history

# history に保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 同じコマンドを history に残さない
setopt hist_ignore_all_dups


###################################
# 色設定
###################################
# ファイルの種類で色分け
# Mac の場合にデフォルトで色分けがされないため設定する
export CLICOLOR=1

# zsh の色設定を変更
# WSL 上の zsh から Windows 環境のファイルを開いた場合に見づらいため設定する
#
# OTHER_WRITABLE 34;42 => 01;32 ... 書き込み権限が付与されたファイルを 文字青;背景緑 から ボールド;文字緑 へ変更
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
# zmv コマンドを使用可能にする
autoload -Uz zmv

# 移動したディレクトリを記録しておく。"cd -[Tab]"で移動履歴を一覧表示
setopt auto_pushd

# ビープ音停止
setopt no_beep
