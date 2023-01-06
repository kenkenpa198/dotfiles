# 参考
# https://qiita.com/koki0527/items/ca734df6fa86a8dbd241
# https://tomiylab.com/2020/03/prompt/


##### 関数定義 #####

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
    echo "[${branch_status}$branch_name${reset}]"
}


##### メイン処理 #####

# プロンプトが表示されるたびにプロンプト文字列を評価して置換する設定
setopt prompt_subst

# プロンプトを表示
PROMPT='%F{179m%}%n@%m%F{black}%B:%F{white}%~%b `prompt-git-current-branch`
%F{087m%}$%F{white} '
