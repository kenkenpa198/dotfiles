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
    cat \
<< msg_help
------------------------------------------------------------------
                    archive-commit-diff v2.0.0
------------------------------------------------------------------
Git コミット間の差分ファイルを ZIP 形式で出力します。

  使用例
----------
    $ bash ./archive-commit-diff.sh <from_commit> <to_commit>
    $ bash ./archive-commit-diff.sh <from_commit> <to_commit> <archive_name>

  使い方
----------
1. Git リポジトリ配下へ移動してください。
    $ cd your-git-repo

2. ブランチ名を <from_commit> と <to_commit> へ指定して実行してください。
    $ bash ./archive-commit-diff.sh 322d4b4 a11729d

3. 差分ファイルのアーカイブがカレントディレクトリへ出力されます。
    .
    ├── .git
    ├── foo_file
    └── archive.zip ★

  補足
--------
コミットの指定には HEAD, コミット ID, タグも使用できます。
    $ bash ./archive-commit-diff.sh main HEAD
    $ bash ./archive-commit-diff.sh 322d4b4 a11729d
    $ bash ./archive-commit-diff.sh v1.0.0 v1.1.0

<archive_name> を指定すると出力先のファイルパスを変更できます。
    $ bash ./archive-commit-diff.sh 322d4b4 a11729d your-filename.zip
    $ bash ./archive-commit-diff.sh 322d4b4 a11729d ../to/relarive/path.zip
    $ bash ./archive-commit-diff.sh 322d4b4 a11729d ~/to/absolute/path.zip
msg_help

    exit 0
}

# エラーメッセージを表示してエラー終了する関数
function print_error_exit() {
    local message=$1
    echo "[ERROR] ${message}"
    echo "使い方を確認するにはオプション '-h' を付与して実行してください。"
    exit 1
}

# コマンド実行エラーを出力してエラー終了する関数
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
# 渡された引数を検証する関数
function validate_parameters() {
    # 第 1 引数がオプション文字列であればヘルプを表示して正常終了
    if (( $# >= 1 )) && [[ $1 == -h ]]; then
        print_help_exit
    fi

    case $# in
        0 )
            # 引数が 0 個の場合はヘルプを表示して正常終了
            print_help_exit
            ;;

        2 | 3 )
            # 引数が 2 個 または 3 個だった場合は正常終了ステータスを返して呼び出し元へ戻る
            return 0
            ;;

        * )
            # 条件にマッチしなければ引数エラーを表示して異常終了
            print_error_exit "引数は 2 個 もしくは 3 個 で指定してください。"
            ;;
    esac
}

# カレントディレクトリが Git リポジトリ内か検証する関数
function validate_inside_repo() {
    if ! git rev-parse --is-inside-work-tree &>/dev/null; then
        print_error_exit "カレントディレクトリが Git リポジトリ外でした。\nこのコマンドは Git リポジトリ内で実行してください。"
    fi
return
}

# git archive コマンドを実行する関数
function do_git_archive() {
    # ローカル変数を宣言
    local from_commit to_commit out_file_path

    # 渡された引数を代入
    from_commit=$1                      # 変更前のコミット
    to_commit=$2                        # 変更後のコミット
    out_file_path="${3:-"archive.zip"}" # デフォルトの出力ファイル名。$3 が未定義の場合は "archive.zip" を代入

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

    # git archive コマンドを実行
    if ! git archive --format=zip --prefix=root/ "$to_commit" "${diff_files[@]}" -o "$out_file_path"; then
        # コマンド実行でエラーが発生した場合はコマンドエラーを出力して異常終了
        print_cmd_error_exit "git archive"
    fi

    # 結果を表示する
    print_result_summary "$from_commit" "$to_commit" "$out_file_path"
    print_result_files "${diff_files[@]}"
}


###################################
# メイン処理
###################################
function main() {
    # スクリプトの実行時に渡された引数を検証
    validate_parameters "$@"

    # カレントディレクトリが Git リポジトリ外だったらエラーを表示して終了
    validate_inside_repo

    # git archive コマンドを実行
    do_git_archive "$@"
}

# メイン処理を実行
main "$@"
