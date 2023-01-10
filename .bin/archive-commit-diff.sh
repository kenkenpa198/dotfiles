#!/bin/bash
set -euo pipefail

# Git リポジトリ上の指定コミット間の差分ファイルを ZIP 形式で出力するシェルスクリプト

# ---------------------------------
# バージョン情報
# ---------------------------------
# - v2.0.0
#     - シェルスクリプトとして刷新。
#     - 指定されたコミットの差分取得に失敗した場合、アーカイブの生成を実行しないように更新。
#
# - v1.1.0
#     - Git リポジトリ外で実行された場合は実行を中止するよう変更。
#     - git archive コマンドの標準エラー出力をエラー文内で表示するように変更。
#     - バージョン情報の出力オプションを追加。
#
# - v1.0.0
#     - 初版作成。


# ---------------------------------
# 関数定義 : メッセージを出力
# ---------------------------------
# ヘルプを出力する関数
print_help() {
    cat \
<< msg_help
------------------------------------------------------------------
                    archive-commit-diff v2.0.0
------------------------------------------------------------------
Git コミット間の差分ファイルを ZIP 形式で出力します。

 Usage
-------
    $ bash ./archive-commit-diff.sh <from_commit> <to_commit>
    $ bash ./archive-commit-diff.sh <from_commit> <to_commit> <archive_name>

 Description
-------------
コミットを特定できる文字列を <from_commit> と <to_commit> へ指定して実行してください。
    $ bash ./archive-commit-diff.sh 322d4b4 a11729d
    $ bash ./archive-commit-diff.sh main feature/mod-branch
    $ bash ./archive-commit-diff.sh main HEAD
    $ bash ./archive-commit-diff.sh v1.0.0 v1.1.0

差分ファイルのアーカイブがカレントディレクトリへ出力されます。
    .
    ├── .git
    ├── foo_file
    └── archive.zip ★

<archive_name> を指定すると出力先のファイルパスを変更できます。
    $ bash ./archive-commit-diff.sh 322d4b4 a11729d mod-filename.zip
    $ bash ./archive-commit-diff.sh 322d4b4 a11729d ../to/relarive/path.zip
    $ bash ./archive-commit-diff.sh 322d4b4 a11729d ~/to/absolute/path.zip
msg_help
    }

# Git リポジトリ外であるエラーを出力する関数
function print_error_outside_repo() {
    cat \
<< msg_error_outside_repo
[ERROR] カレントディレクトリが Git リポジトリ外でした。
Git リポジトリ内で実行してください。

使い方を確認するにはオプション '-h' を付与して実行してください。
msg_error_outside_repo
    }

# 引数エラーを出力する関数
function print_error_args() {
    cat \
<< msg_error_args
[ERROR] 引数は 2 個 もしくは 3 個 で指定してください。
使い方を確認するにはオプション '-h' を付与して実行してください。
msg_error_args
    }

# コマンド実行エラーを出力する関数
# $1 : エラーが起こったコマンドの文字列
# $2 : 標準エラー出力の文字列
function print_error_do_command() {
    cat \
<< msg_error_do_command

[ERROR] ${1} コマンドの実行中にエラーが発生しました。
出力されているエラー内容を確認してください。

使い方を確認するにはオプション '-h' を付与して実行してください。
msg_error_do_command
    }

# 出力結果（概要）を表示する関数
function print_result_summary() {
    cat \
<< msg_result_summary
アーカイブを出力しました。
------------------------------------------------------------------
変更前のコミット : ${1}
変更後のコミット : ${2}
出力先           : ./${3}
msg_result_summary
}

# 出力結果（差分ファイル）を表示する関数
function print_result_files() {
    echo "------------------------------------------------------------------"
    for file in "$@"; do
        echo "$file"
    done
    echo "------------------------------------------------------------------"
}


# ---------------------------------
# 関数定義 : 処理系
# ---------------------------------
# 渡された引数を検証する関数
function validate_parameters() {
    # 第 1 引数がオプション文字列であればヘルプを表示して正常終了
    if (( $# >= 1 )) && [[ $1 == -h ]]; then
        print_help
        exit 0
    fi

    # 引数の個数に異常があれば引数エラーを表示して異常終了
    if (( $# < 2 )) || (( $# > 3)); then
        print_error_args
        exit 1
    fi
}

# カレントディレクトリが Git リポジトリ内か検証する関数
function validate_inside_repo() {
    if ! git rev-parse --is-inside-work-tree &>/dev/null; then
        # Git リポジトリ外であればエラー文を表示して異常終了
        print_error_outside_repo
        exit 1
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
    out_file_path="${3:-"archive.zip"}" # デフォルトの出力ファイル名。$3 が未定義の場合は "archive.zip" で初期化

    # git diff コマンドの実行確認
    if ! git diff --name-only "$from_commit" "$to_commit" --diff-filter=ACMR > /dev/null; then
        # コマンド実行でエラーが起こった場合はコマンドエラーを出力して異常終了
        print_error_do_command "git diff"
        exit 1
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
    #     print_error_do_command "git diff"
    #     exit 1
    # fi
    # ----------------------------------------------------------------------------------------------

    # git archive コマンドを実行
    if ! git archive --format=zip --prefix=root/ "$to_commit" "${diff_files[@]}" -o "$out_file_path"; then
        # コマンド実行でエラーが起こった場合はコマンドエラーを出力して異常終了
        print_error_do_command "git archive"
        exit 1
    fi

    # 結果を表示する
    print_result_summary "$from_commit" "$to_commit" "$out_file_path"
    print_result_files "${diff_files[@]}"
}


# ---------------------------------
# メイン処理
# ---------------------------------
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
