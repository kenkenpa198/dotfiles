#!/bin/bash
set -euo pipefail

# ------------------------------------------------------------------
#                     archive-commit-diff v2.0.0
# ------------------------------------------------------------------
# Git リポジトリ上の指定コミット間の差分ファイルを ZIP 形式で出力するシェル関数

# 参考:
# [[Git]masterと作業ブランチの差分ファイルを抽出してzip化する | いまからむったーん](https://muttaan.com/git-diffextraction/)
# [Gitで差分ファイルを抽出+zipファイル化する方法 | 株式会社グランフェアズ](https://www.granfairs.com/blog/staff/git-archivediff)
# [Gitレポジトリの中にいるか確認する方法 | 晴耕雨読](https://tex2e.github.io/blog/git/check-if-inside-git-repo)
# [コマンドの標準エラー出力を変数に代入 - ハックノート](https://hacknote.jp/archives/20651/)


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
Git リポジトリ上で指定したコミット間の差分ファイルを ZIP 形式で出力します。

 使い方
--------
1. Git リポジトリのルートディレクトリへ移動する。
  $ cd foo_git_dir

2. 第 1 引数に変更前のコミット、第 2 引数に変更後のコミットを指定して送信する。
  $ acd from_commit to_commit

3. 差分をアーカイブ化した ZIP ファイルがカレントディレクトリに生成される。
  .
  ├── .git
  ├── bar_file
  ├── baz_file
  └── archive.zip ★ 生成

 使用例
--------
コミットの指定にはコミット ID やブランチ名などが使えます。
  $ acd 322d4b4 a11729d
  $ acd main feature/aaaaa
  $ acd main HEAD

第 3 引数にファイルパスを指定すると、好みのファイル名やディレクトリへ出力を行えます。
  $ acd from_commit to_commit fuga.zip
  $ acd from_commit to_commit ../fuga.zip
  $ acd from_commit to_commit ~/aaa/fuga.zip

 補足
------
オプション指定でドキュメントを表示します。
  $ acd -h : ヘルプを表示する
  $ acd -v : バージョン情報を表示する

指定されたコミットが見つからなかった場合はエラーメッセージを表示します。
  - この際、空の ZIP ファイルがカレントディレクトリへ出力されます。
    確認して削除をお願いします。
msg_help
    }

# バージョン情報を出力する関数
function print_version() {
    cat \
<< msg_version
------------------------------------------------------------------
                    archive-commit-diff v2.0.0
------------------------------------------------------------------
- v2.0.0
    - シェルスクリプトとして刷新。

- v1.1.0
    - Git リポジトリ外で実行された場合は実行を中止するよう変更。
    - git archive コマンドの標準エラー出力をエラー文内で表示するように変更。
    - バージョン情報の出力オプションを追加。
    - コードのリファクタリング。

- v1.0.0
    - 初版作成。
msg_version
    }

# Git リポジトリ外であるエラーを出力する関数
function print_error_outside_repo() {
    cat \
<< msg_error_outside_repo
[!] カレントディレクトリが Git リポジトリ外でした。
Git リポジトリ内で実行してください。

使い方を確認するには 'acd -h' を送信してください。
msg_error_outside_repo
    }

# 引数エラーを出力する関数
function print_error_args() {
    cat \
<< msg_error_args
[!] 引数は 2 個 もしくは 3 個 で指定してください。

 使用例
--------
  $ acd from_commit to_commit
  $ acd from_commit to_commit fuga.zip

使い方を確認するには 'acd -h' を送信してください。
msg_error_args
    }

# コマンド実行エラーを出力する関数
# $1 : 標準エラー出力の文字列
function print_error_git_archive() {
    cat \
<< msg_error_git_archive
[!] git archive コマンドの実行中にエラーが発生しました。
echo $1

出力されたエラー内容を確認してください。
使い方を確認するには 'acd -h' を送信してください。
msg_error_git_archive
    }

# 出力したコミットとファイルの情報を表示する関数
#
function print_result() {
    cat \
<< msg_result
差分ファイルを出力しました。
変更前のコミット : $1
変更後のコミット : $2
出力先           : ./$3
msg_result
}


# ---------------------------------
# 関数定義 : 処理系
# ---------------------------------
# 渡された引数を検証する関数
function validate_parameters() {
    # 第 1 引数がオプション文字列であればドキュメント表示用関数を実行して正常終了
    if (( $# >= 1 )); then
        case "$1" in
            -h | --help)
                print_help
                exit 0
                ;;

            -v | --version)
                print_version
                exit 0
                ;;
        esac
    fi

    # 引数の個数で条件分岐
    case $# in
        0 )
            # 引数が 0 個の場合はヘルプを表示して正常終了
            print_help
            exit 0
            ;;

        2 | 3 )
            # 引数が 2 個 または 3 個だった場合は正常終了ステータスを返して呼び出し元へ戻る
            return 0
            ;;

        * )
            # 条件にマッチしなければ引数エラーを表示して異常終了
            print_error_args
            exit 1
            ;;
    esac
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
    from_commit="$1"                    # 変更前のコミット
    to_commit="$2"                      # 変更後のコミット
    out_file_path="${3:-"archive.zip"}" # デフォルトの出力ファイル名。$3 が未定義の場合は "archive.zip" で初期化

    # git diff コマンドを実行して差分ファイルの配列を取得
    local diff_files
    diff_files=($(git diff --name-only "$from_commit" "$to_commit" --diff-filter=ACMR))

    # git archive コマンドを実行
    local git_archive_error
    if ! git_archive_error="$(git archive --format=zip --prefix=root/ "$to_commit" "${diff_files[@]}" -o "$out_file_path" 2>&1 > /dev/null)"; then
        # コマンド実行でエラーが起こった場合、変数 e へ代入された標準エラー出力を print_error_git_archive 関数へ渡して実行する
        print_error_git_archive "$git_archive_error"

        # 異常終了
        exit 1
    fi

    # 結果を表示する
    print_result "$from_commit" "$to_commit" "$out_file_path"
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
