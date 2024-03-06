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


###################################
# プロンプトテーマ
###################################
# 参考
# https://qiita.com/koki0527/items/ca734df6fa86a8dbd241
# https://tomiylab.com/2020/03/prompt/

# コマンドの実行ごとに改行する
function precmd() {
    if [ -z "$NEW_LINE_BEFORE_PROMPT" ]; then
        NEW_LINE_BEFORE_PROMPT=1
    elif [ "$NEW_LINE_BEFORE_PROMPT" -eq 1 ]; then
        echo ""
    fi
}

# git ブランチ名を色付きで表示する
function prompt-git-current-branch {
    local branch_name st branch_status

        color='%{\e[38;5;' # 文字色を設定
        green='114m%}'
        red='001m%}'
        yellow='227m%}'
        blue='033m%}'
        reset='%{\e[0m%}'  # reset

    if [ ! -e ".git" ]; then
        # git 管理されていないディレクトリは何も返さない
        return
    fi

    branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
    st=`git status 2> /dev/null`

    if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
        # 全て commit されてクリーンな状態
        branch_status="${color}${green}"
    elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
        # git 管理されていないファイルがある状態
        branch_status="${color}${red}?"
    elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
        # git add されていないファイルがある状態
        branch_status="${color}${red}+"
    elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
        # git commit されていないファイルがある状態
        branch_status="${color}${yellow}!"
    elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
        # コンフリクトが起こった状態
        echo "${color}${red}!(no branch)${reset}"
        return
    else
        # 上記以外の状態の場合
        branch_status="${color}${blue}"
    fi

    # ブランチ名を色付きで表示する
    echo "%F{white}[${branch_status}$branch_name${reset}%F{white}]"
}

# プロンプトが表示されるたびにプロンプト文字列を評価して置換する設定
setopt prompt_subst

# プロンプトを表示
PROMPT='%F{179m%}%n@%m%F{black}%B:%F{white}%~%b `prompt-git-current-branch`
%F{087m%}$%F{white} '
