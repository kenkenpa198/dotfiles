<!-- omit in toc -->
# アーカイブ.md

今はもう使ってないけどまた使いそうなコマンドや、  
後でまとめておくつもりの設定などを書き留めておくマークダウン。

## 1. コマンド残骸

### 1.1. Open with Chrome

Google Chrome で指定したファイルを開く WSL2 環境用コマンド。  
explorer.exe へファイルパスを渡せば普通にできた（完）

`readlink` とかは今後使えそうなのでアーカイブ化。

参考:

- [ファイルの絶対パスを取得する - アメリエフの技術ブログ](https://staffblog.amelieff.jp/entry/2018/05/30/094427)
- [HTMLファイルをコマンドラインから開く - Qiita](https://qiita.com/hkato/items/9ed477788633d1a62a7a)

```shell
oc() {
    local file_path absolute_file_path win_absolute_file_path
    file_path=$1

    # 引数のファイルが存在すれば処理開始
    if [ -e $file_path ]; then
        # ファイルの絶対パスを取得
        absolute_file_path=`readlink -f $file_path`

        # ファイルパスを Win 環境のものに変換
        win_absolute_file_path=`wslpath -w $absolute_file_path`

        # CMD から chrome を呼び出して開く
        cmd.exe /c start "${win_absolute_file_path}"

    # 引数にファイルが存在しなければ何もしない
    else
        echo "file is not found."
    fi
}
```
