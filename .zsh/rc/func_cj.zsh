##### CST to JST #####
# CST（日本標準時）と JST（米国中部標準時）を出力・計算するシェル関数

cj() {
    ##### 関数の定義 #####
    # ヘルプ表示関数
    function display_help() {
        cat \
<< help_msg
----------------------------------------------------------------
                           CST to JST
----------------------------------------------------------------
CST（米国中部標準時）と JST（日本標準時）を計算して出力します。
時差は一律 15h として計算します。サマータイムは考慮しません。

  引数なし   : 現在の CST と JST を出力します。
  -c         : 指定日時を CST とした場合の JST を出力します。
  -j         : 指定日時を JST とした場合の CST を出力します。
  -h, --help : コマンド一覧を出力します。

  使用例
----------
オプションなしの実行で現在の CST と JST を出力します。
  $ cj

オプション + 日時指定 で計算を行えます。日時は ' ' で囲んでください。
  $ cj -c '2022-03-15 12:00:00'
  $ cj -j '2022-03-15 12:00:00'

計算時の日時形式はいろいろ対応しています。
  $ cj -c '2022/3/15 8:30:00 PM'
  $ cj -j 'Tue Mar 15 20:17:45 2022'

日付や時間はある程度省略可能です。省略部分には当日0時を基準にした値が入ります。
  $ cj -j '2022-03-15'
  $ cj -j '4/15'
  $ cj -j '12:00:00'
  $ cj -j '11:50'
help_msg
    }

    # ローカル変数の宣言
    local \
        notice_msg \
        cst_mark \
        jst_mark \
        utc_dt \
        cst_dt \
        jst_dt

    # 引数が無ければ現在の CST と UTC を計算する
    if [ $# = 0 ]; then

        # 出力用の表示を設定
        notice_msg="Display current CST and JST."
        cst_mark=" "
        jst_mark=" "

        # 計算の基準となる現在の UTC 日時を取得
        # 実行環境によるタイムゾーンの違いを考慮するため、UTC 日時を現在の CST と UTC を計算する基準としている
        utc_dt=`date +'%F (%a) %T' -u`

        # UTC から CST を計算
        cst_dt=`date +'%F (%a) %T' -d "${utc_dt} 6 hours ago" -u`

        # UTC から JST を計算
        jst_dt=`date +'%F (%a) %T' -d "${utc_dt} 9 hours" -u`

    # -c 引数を受け取った場合は第2引数を CST として JST を計算する
    elif [ $1 = "-c" ] && [ $# = 2 ]; then

        # 出力用の表示を設定
        notice_msg="Converted CST to JST."
        cst_mark="*"
        jst_mark=" "

        # 与えられた日付をフォーマットして CST として格納
        cst_dt=`date +'%F (%a) %T' -d "${2}"`

        # CST から JST を計算
        jst_dt=`date +'%F (%a) %T' -d "${cst_dt} 15 hours"`

    # -j 引数を受け取った場合は第2引数を JST として CST を計算する
    elif [ $1 = "-j" ] && [ $# = 2 ]; then

        # 出力用の表示を設定
        notice_msg="Converted JST to CST."
        cst_mark=" "
        jst_mark="*"

        # 与えられた日付をフォーマットして JST として格納
        jst_dt=`date +'%F (%a) %T' -d "${2}"`

        # JST から CST を計算
        cst_dt=`date +'%F (%a) %T' -d "${jst_dt} 15 hours ago"`

    # -h, --help の場合はコマンド一覧を表示して終了
    elif [ $1 = "-h" ] || [ $1 = "--help" ]; then
        display_help
        return 0

    # 引数指定に当てはまらなかったらエラー文を表示して終了
    else
        echo "引数を受け取れませんでした。"
        echo "使い方を確認するには "\'"cj -h"\'" を送信してください。"
        return 1
    fi

    # 結果の出力
    cat \
<<result
${notice_msg}
--------------------------------
${cst_mark} CST: ${cst_dt}
${jst_mark} JST: ${jst_dt}
result

}
