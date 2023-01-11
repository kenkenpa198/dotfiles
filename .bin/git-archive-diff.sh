#!/bin/bash
set -euo pipefail

# Git リポジトリ上の指定コミット間の差分ファイルを ZIP 形式で出力するシェルスクリプト。

###################################
# バージョン情報
###################################
# - v2.0.0
#     - シェルスクリプトとして刷新。
#     - 指定されたコミットの差分取得に失敗した場合、アーカイブの生成を実行しないように更新。
#     - ファイル名にスペースが含まれていると別のファイル名として変数展開されてしまい実行に失敗する問題を修正
#
# - v1.1.0
#     - Git リポジトリ外で実行された場合は実行を中止するよう更新。
#
# - v1.0.0
#     - 初版作成。


###################################
# 関数定義 : メッセージを表示
###################################
# ヘルプを表示して正常終了する関数
print_help_exit() {
    # 引数が存在しない または 第 1 引数がオプション文字列である場合のみ実行
    if [[ $# = 0 ]] || [[ $1 == -h ]]; then

        # ヒアドキュメントを出力
        cat \
<< msg_help
-----------------------------------------------------------------
                     git-archive-diff v2.0.0
-----------------------------------------------------------------
Git コミット間の差分ファイルを ZIP 形式で出力します。

  使用例
----------
    $ bash ./git-archive-diff.sh <from_commit> <to_commit>
    $ bash ./git-archive-diff.sh <from_commit> <to_commit> <archive_name>

  使い方
----------
1. Git リポジトリ配下へ移動してください。
    $ cd your-git-repo

2. コミットの識別子を <from_commit> と <to_commit> へ指定して実行してください。
    $ bash ./git-archive-diff.sh main feature/your-branch

3. 差分ファイルのアーカイブがカレントディレクトリへ出力されます。
    .
    ├── .git
    ├── foo_file
    └── archive.zip ★

  補足
--------
コミットの識別子は ブランチ, HEAD, コミット ID, タグ が使用できます。
    $ bash ./git-archive-diff.sh main feature/your-branch
    $ bash ./git-archive-diff.sh main HEAD
    $ bash ./git-archive-diff.sh 322d4b4 a11729d
    $ bash ./git-archive-diff.sh v1.0.0 v1.1.0

<archive_name> を指定すると出力先のファイルパスを変更できます。
    $ bash ./git-archive-diff.sh 322d4b4 a11729d your-filename.zip
    $ bash ./git-archive-diff.sh 322d4b4 a11729d ../to/relarive/path.zip
    $ bash ./git-archive-diff.sh 322d4b4 a11729d ~/to/absolute/path.zip
msg_help

        # 正常ステータスで終了
        exit 0
    fi
}

# エラーメッセージを表示して異常終了する関数
function print_error_exit() {
    local message=$1
    echo "[ERROR] ${message}"
    echo "使い方を確認するにはオプション '-h' を付与して実行してください。"
    exit 1
}

# コマンド実行エラーを出力して異常終了する関数
# $1 : エラーが発生したコマンド
function print_cmd_error_exit() {
    local command=$1
    echo ""
    echo "[ERROR] ${command} コマンドの実行中にエラーが発生しました。"
    echo "出力されているエラー内容を確認してください。"
    echo "使い方を確認するにはオプション '-h' を付与して実行してください。"
    exit 1
}

# 出力結果（概要）を表示する関数
function print_result_summary() {
    echo "アーカイブを出力しました。"
    echo "------------------------------------------------------------------"
    echo "変更前のコミット : ${1}"
    echo "変更後のコミット : ${2}"
    echo "出力先           : ./${3}"
}

# 出力結果（差分ファイル）を表示する関数
function print_result_files() {
    echo "------------------------------------------------------------------"
    for file in "$@"; do
        echo "$file"
    done
    echo "------------------------------------------------------------------"
}


###################################
# 関数定義 : 処理系
###################################
# 渡された引数の個数を検証する関数
function validate_parameters_count() {
    if (( $# < 1 )) || (( $# > 2 )); then
        print_error_exit "引数は 1 個 もしくは 2 個 で指定してください。"
    fi
}

# カレントディレクトリが Git リポジトリ内か検証する関数
function validate_inside_repo() {
    if ! git rev-parse --is-inside-work-tree &>/dev/null; then
        print_error_exit "このスクリプトは Git リポジトリ上で実行してください。"
    fi
return
}

# git archive コマンドを実行する関数
# $1 : 変更前のコミット識別子
# $2 : 変更後のコミット識別子（省略した場合は "HEAD" を代入）
function do_git_archive() {
    # コミット識別子をローカル変数へ代入
    local from_commit to_commit
    from_commit=$1           # 変更前のコミット
    to_commit="${2:-"HEAD"}" # 変更後のコミット。$2 が未定義の場合は "HEAD" を代入

    # git diff コマンドの実行確認
    if ! git diff --name-only "$from_commit" "$to_commit" --diff-filter=ACMR > /dev/null; then
        # コマンド実行でエラーが発生した場合はコマンドエラーを出力して異常終了
        print_cmd_error_exit "git diff"
    fi

    # git diff コマンドの標準出力を配列として保存
    local diff_files
    mapfile -t diff_files < <(git diff --name-only "$from_commit" "$to_commit" --diff-filter=ACMR)

    # echo "${diff_files[@]}"

    # NOTE:
    # 以下だとより少ない行で git diff のエラー処理を書けるが、
    # ファイル名にスペースが含まれていた場合に別のファイル名として変数展開されてしまう
    # ----------------------------------------------------------------------------------------------
    # if ! diff_files=($(git diff --name-only "$from_commit" "$to_commit" --diff-filter=ACMR)); then
    #     print_cmd_error_exit "git diff"
    # fi
    # ----------------------------------------------------------------------------------------------

    # ファイル名を定義
    local export_path
    export_path="$(basename "$PWD")-$(date '+%Y%m%d_%H%M%S').zip" # ディレクトリ名-yyyymmdd_hhmmss.zip

    # git archive コマンドを実行
    if ! git archive --format=zip --prefix=root/ "$to_commit" "${diff_files[@]}" -o "$export_path"; then
        # コマンド実行でエラーが発生した場合はコマンドエラーを出力して異常終了
        print_cmd_error_exit "git archive"
    fi

    # 結果を表示する
    print_result_summary "$from_commit" "$to_commit" "$export_path"
    print_result_files "${diff_files[@]}"
}


###################################
# メイン処理
###################################
function main() {
    # ヘルプの表示判定処理
    print_help_exit "$@"

    # カレントディレクトリが Git リポジトリ内か検証
    validate_inside_repo

    # 引数の個数を検証
    validate_parameters_count "$@"

    # git archive コマンドを実行
    do_git_archive "$@"
}

# メイン処理を実行
main "$@"
