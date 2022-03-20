##### CST to JST #####
# CST（日本標準時）と JST（米国中部標準時）を出力・計算する関数

cj() {

    # local 変数の指定
    local \
        display_msg \
        cst_mark \
        jst_mark \
        utc_dt \
        cst_dt \
        jst_dt

    # 引数が無ければ現在の CST と UTC を計算する
    if [ $# = 0 ]; then

        # 出力用の表示を設定
        display_msg="Display current CST and JST."
        cst_mark=" "
        jst_mark=" "

        # 計算の基準となる現在の UTC 日時を取得
        # 実行環境によるタイムゾーンの違いを考慮するため、UTC 日時を現在の CST と UTC を計算する基準としている
        utc_dt=`date -u`

        # UTC から CST を計算
        cst_dt=`date +'%F (%a) %T' -d "${utc_dt} 6 hours ago"`

        # UTC から JST を計算
        jst_dt=`date +'%F (%a) %T' -d "${utc_dt} 9 hours"`

    # -c 引数を受け取った場合は第2引数を CST として JST を計算する
    elif [ $1 = "-c" ] && [ $# = 2 ]; then

        # 出力用の表示を設定
        display_msg="Converted CST to JST."
        cst_mark="*"
        jst_mark=" "

        # 与えられた日付をフォーマットして CST として格納
        cst_dt=`date +'%F (%a) %T' -d "${2}"`

        # CST から JST を計算
        jst_dt=`date +'%F (%a) %T' -d "${cst_dt} 15 hours"`

    # -j 引数を受け取った場合は第2引数を JST として CST を計算する
    elif [ $1 = "-j" ] && [ $# = 2 ]; then

        # 出力用の表示を設定
        display_msg="Converted JST to CST."
        cst_mark=" "
        jst_mark="*"

        # 与えられた日付をフォーマットして JST として格納
        jst_dt=`date +'%F (%a) %T' -d "${2}"`

        # JST から CST を計算
        cst_dt=`date +'%F (%a) %T' -d "${jst_dt} 15 hours ago"`

    # --help -h の場合はコマンド一覧を表示して終了
    elif [ $1 = "--help" ] || [ $1 = "-h" ]; then

        echo "----------------------------------------------------------------"
        echo "                           CST to JST"
        echo "----------------------------------------------------------------"
        echo "CST（米国中部標準時）と JST（日本標準時）を出力します。"
        echo "時差は一律 15h として計算します。サマータイムは考慮しません。"
        echo
        echo "  引数なし   : 現在の CST と JST を出力します。"
        echo "  -c         : 指定日時を CST とした場合の JST を出力します。"
        echo "  -j         : 指定日時を JST とした場合の CST を出力します。"
        echo "  -h, --help : コマンド一覧を出力します。"
        echo
        echo
        echo "  使用例"
        echo "----------"
        echo "引数なしの実行で現在の CST と JST を出力します。"
        echo "  $ cj "
        echo
        echo "オプション + 日時指定 で計算を行えます。日時は "\'" "\'" で囲んでください。"
        echo "  $ cj -c "\'"2022-03-15 12:00:00"\'
        echo "  $ cj -j "\'"2022-03-15 12:00:00"\'
        echo
        echo "計算時の日時形式はいろいろ対応しています。"
        echo "  $ cj -c "\'"2022/3/15 8:30:00 PM"\'
        echo "  $ cj -j "\'"Tue Mar 15 20:17:45 2022"\'
        echo
        echo "日付や時間は省略可能です。省略部分には当日0時を基準にした値が入ります。"
        echo "  $ cj -j "\'"2022-03-15"\'
        echo "  $ cj -j "\'"4/15"\'
        echo "  $ cj -j "\'"12:00:00"\'
        echo "  $ cj -j "\'"11:50"\'
        return

    # 引数指定に当てはまらなかったらエラー文を表示して終了
    else
        echo "引数を受け取れませんでした。"
        echo "使い方を確認するには "\'"cj --help"\'" を送信してください。"
        return
    fi

    # 結果の出力
    echo "${display_msg}"
    echo "--------------------------------"
    echo "${cst_mark} CST: ${cst_dt}"
    echo "${jst_mark} JST: ${jst_dt}"
}
