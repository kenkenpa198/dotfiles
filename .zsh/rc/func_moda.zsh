##### moda #####
# もだねちゃんが来てくれる関数！！

# 参考:
# [bashでコマンドが無い時にやる夫が動いて煽ってくるcommand_not_found_handle() | 俺的備忘録 〜なんかいろいろ〜](https://orebibou.com/ja/home/201810/20181005_001/)
# [bash をウザくする - とりあえず暇だったし何となくはじめたブログ](https://khiker.hatenablog.jp/entry/20070814/bash_yaruo)

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
        ( ____   ﾚ-、
      ／       -ノ_ﾗ
     "  人      ヽ
   /  ／_ \`-_     \\
  |  /        \`-_  |
  (|| -==    ==- ||)
   \\) ,,  ワ  ,, (ﾉ
    )ヽ________ノ(
        \_父_/
big_modane

    # -a, --anime 引数を受け取った場合はデカもだねちゃんのアニメーションを出力
    elif [ $1 = "-a" ] || [ $1 = "--anime" ]; then
        clear
        cat \
<<anime_modane_01
                ____
              /      \\
             ( ____   ﾚ-、
           ／       -ノ_ﾗ
          "  人      ヽ
        /  ／_ \`-_     \\
       |  /        \`-_  |
       (||   |    |   ||)
        \\) ,,  ー  ,, (ﾉ
         )ヽ________ノ(
             \_父_/
anime_modane_01

        sleep 1
        clear

        cat \
<<anime_modane_02
                ____
              /      \\
             ( ____   ﾚ-、
           ／       -ノ_ﾗ
          "  人      ヽ
        /  ／_ \`-_     \\
       |  /        \`-_  |
       (||   |    |   ||)  < やっほー！
   mm,  \\) ,,  ワ  ,, (ﾉ
   \_ﾉ   )ヽ________ノ(
             \_父_/
anime_modane_02

        sleep 1
        clear

        cat \
<<anime_modane_03
                ____
              /      \\
             ( ____   ﾚ-、
           ／       -ノ_ﾗ
   \\      "  人      ヽ
  --    /  ／_ \`-_     \\
  _-   |  /        \`-_  |
       (|| -==    ==- ||)  < やっほー！
   mm,  \\) ,,  ワ  ,, (ﾉ     もだねちゃんだよ！
   \_ﾉ   )ヽ________ノ(
             \_父_/
anime_modane_03

        sleep 1

    # -h, --help 引数を受け取った場合はコマンド一覧を表示
    elif [ $1 = "-h" ] || [ $1 = "--help" ]; then
    cat \
<< help_msg
,( )
('_')/ This is the function that Modane-chan is coming to.

options
  no options  : Small Modane-chan will come.
  -b, --big   : BIG MODANE-CHAN appears!
  -a, --anime : BIG MODANE-CHAN animates!
  -h, --help  : display usage.
help_msg

    # 引数指定に当てはまらなかったらエラー文を表示して終了
    else
        cat \
<< option_error_msg
  ( ),
(>_<) It option is undefined.
      Please send 'moda -h'.
option_error_msg

    fi

    return 0
}
