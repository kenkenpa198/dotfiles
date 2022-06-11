##### moda #####
# もだねちゃんが来てくれる関数！！

moda() {

    # 引数が無ければミニもだねちゃんを出力
    if [ $# = 0 ]; then
        cat \
<< small_modane
   ( ),
\(^_^) moda!
small_modane

    # -b, --big 引数を受け取った場合はデカもだねちゃんを出力
    elif [ $1 = "-b" ] || [ $1 = "--big" ]; then
        cat \
<<big_modane
                ____
              /      \\
             ( ____   ﾄ-、
           ／       -ノ_ﾗ
   \\      "  人      ヽ
  --    /  ／_ \`-_     \\
  _-   |  /        \`-_  |
       (|| -==    ==- ||)  < やっほー！
   mm,  \\) ,,  ワ  ,, (ﾉ     もだねちゃんだよ！
   \_ﾉ   )ヽ________ノ(
             \_父_/
big_modane

    # -h, --help 引数を受け取った場合はコマンド一覧を表示
    elif [ $1 = "-h" ] || [ $1 = "--help" ]; then
    cat \
<< help_msg
,( )
('_')/ This function is display Modane-chan.

options
  no options : Small Modane-chan will come.
  -b, --big  : BIG MODANE-CHAN appears!
  -h, --help : display usage.
help_msg

    # 引数指定に当てはまらなかったらエラー文を表示して終了
    else
        cat \
<< option_error_msg
  ( ),
(>_<) It option is undefined.
      Please send 'moda --help'.
option_error_msg

    fi

    return 0
}
