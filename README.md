<!-- omit in toc -->
# dotfiles

```shell
$ cd
$ git clone https://github.com/kenkenpa198/dotfiles.git
$ source ~/dotfiles/.setup/Ubuntu/setup.sh
```

## 1. 概要

kenkenpa198 の dotfiles 。  
シンボリックリンクで色々つなげて、設定の変更を Git で検知して管理している。  

## 2. 構築方法

1. Windows 環境の場合、先に WSL をセットアップしておく。  

    ```powershell
    # PowerShell（管理者権限で起動）
    > wsl --install
    ```

    参考: [WSL のインストール | Microsoft Learn](https://learn.microsoft.com/ja-jp/windows/wsl/install)

2. ホームディレクトリ上で冒頭のコマンドを実行して dotfiles をクローン & Ubuntu 環境のセットアップ。
3. `.setup/` 配下のスクリプトを使用してシンボリックリンクを各ファイルへ繋げる。

その他補足資料は [docs](docs) ディレクトリにて。

## 3. 構成

### 3.1. bashrc / zshrc

```shell
.
├── .bashrc
├── .zsh
│   ├── .dircolors
│   └── rc
│       ├── function
│       │   ├── foo.zsh
│       │   └── bar.zsh
│       ├── alias.zsh
│       ├── env.zsh
│       ├── option.zsh
│       ├── theme.zsh
│       └── secret.zsh（Git 管理外）
└── .zshrc
```

当 dotfiles の主人公である `.zshrc` と仲間たち。  

`.zshrc` へは `.zsh/rc/` ディレクトリ配下の `**.zsh` を読み込むコードのみを記述。  
エイリアスなどは `.zsh/` ディレクトリ配下の各設定ファイルへ分けて記述する。  
こうすることで、使い勝手は変わりないまま設定ファイルを整理することができる。

同様に `.bashrc` も `alias.zsh` `env.zsh` を使いまわしている。

`secret.zsh` はトークンの環境変数等、セキュアな情報を記述したファイル。  
後述のホワイトリストには記述していないため Git 上には登録されない。  
未来の自分は環境を変えた時に移行し忘れないようにしてね！

`.zsh/rc/function/` ディレクトリ配下のスクリプトは `alias.zsh` から切り離した自作のシェル関数。  
それぞれの関数については [4. 自作シェル関数](#4-自作シェル関数) セクションに記載。  

### 3.2. config

```shell
.
└── .config
     ├── ***
     └── ***
```

`.config/` ディレクトリ配下には VSCode などアプリごとの設定ファイルを保管。  
基本的には各設定ファイルのコメントや [mklink.bat](.setup/Windows/mklink.bat) などを参考にそれぞれシンボリックリンクを繋げる。

Windows Terminal の `settings.json` と WSL 用の `.wslconfig` のみ、シンボリックリンクではなくコピペや複製で対応する。  
WSL が立ち上がる前に WSL 内のファイルを読み込もうとして失敗してしまうようなため。

Windows Terminal の設定ファイルは GUID 設定を上書きしないよう注意。  
上書きしちゃったら `設定 $ 新しいプロファイルを追加します $ プロファイルを複製する` から該当のプロファイルを選んで複製 → 複製されたプロファイルの GUID で設定しなおす。

### 3.3. git

```shell
.
├── .gitconfig_shared
└── .gitignore_global
```

作業環境用の `.gitconfig` の基本設定やグローバルな除外設定を管理。

`.gitconfig` の基本設定は `.gitconfig_shared` に切り分け、`.gitignore_global` と同様に `.gitconfig` へ外部読み込み設定を行うような運用にしている。  
`.gitconfig` にはメアドとユーザー名を記述する必要があり、Git 管理の対象にしたくなかったため。

`.gitignore_global` を設定する前にコミットをしてしまうと、コミット済みのファイルには適用されなくなるので注意。  
やらかしたら下記コマンドでキャッシュを削除してから改めてコミットする。

```shell
$ git rm -r --cached .
```

### 3.4. gitignore

```shell
.
└── .gitignore
```

当 dotfiles 用の `.gitignore` 。  

ホワイトリスト形式にすることで、`.gitignore` で指定したファイルのみしか Git の管理下に入らないようにしている。  
こうすることで誤ってコミットしてしまうミスを防げる。

### 3.5. setup

```shell
.
└── .setup
     ├── Ubuntu
     │   ├── ***.sh
     │   └── ***.sh
     └── Windows
         ├── ***.bat
         └── ***.bat
```

`.setup/` 配下にはセットアップ用のスクリプトファイル関連を保管。  
こちらを実行したり、記述を拾ったりしつつ環境を整える。

それぞれコマンドを単純に直書きしているだけなので、もう少しいい感じにしたい。

## 4. 自作シェル関数

`.zsh/rc/function/` 配下に保存している自作の各シェル関数。

使ってみたい場合は内容をそのまま .bashrc などに記述してもらえれば動くと思います。  
それぞれ `-h` オプションでヘルプを表示します。

### 4.1. [acd 関数](.zsh/rc/function/acd.zsh)

Git リポジトリ上で指定したコミット間の差分ファイルを ZIP 形式で出力する関数。  
名前は「Archive Commit Diff」の略。

Example :

```shell
$ acd main feature/add_tsukune
変更前のコミット : main
変更後のコミット : feature/add_tsukune

差分ファイルを出力しました。
archive.zip
```

### 4.2. [cj 関数](.zsh/rc/function/cj.zsh)

CST（米国中部標準時）と JST（日本標準時）を計算して出力する関数。  
名前は「CST to JST」の略。

Example :

```shell
$ cj -c 'Sun, 22 Dec 2021 11:56:26'
Converted CST to JST.
--------------------------------
* CST: 2021-12-22 (Wed) 11:56:26
  JST: 2021-12-23 (Thu) 02:56:26
```

### 4.3. [moda 関数](.zsh/rc/function/moda.zsh)

もだねちゃんが来てくれる関数。  
引数指定で大きくなったりアニメーションしたりします。

Example :

```shell
$ moda
   ( ),
\(^_^) moda!
```

## 5. 参考サイト

### 5.1. dotfiles

- [ようこそdotfilesの世界へ - Qiita](https://qiita.com/yutakatay/items/c6c7584d9795799ee164)
- [【初心者版】必要最小限のdotfilesを運用する - Qiita](https://qiita.com/ganariya/items/d9adffc6535dfca6784b)
- [gitignoreのホワイトリストの書き方 - Qiita](https://qiita.com/sventouz/items/574bd67c7e43fff10546)
- [Windows と Mac で開発環境を揃える Tips 集 - Neo's World](https://neos21.net/tech/windows-mac-environment.html)

### 5.2. WSL2

- [WSL のインストール | Microsoft Docs](https://docs.microsoft.com/ja-jp/windows/wsl/install)
- [Windows Terminal + WSL 2 + Homebrew + Zsh - Qiita](https://qiita.com/okayurisotto/items/36f6f9df499a74e62bff)
- [windows10でVSCode+WSL2(Ubuntu)+Docker Desktopの開発環境を作る](https://zenn.dev/ivgtr/scraps/92e14f80683be9)
- [WSL その128 - Windowsの環境変数とLinuxの環境変数を相互に引き継ぎ可能に - kledgeb](https://kledgeb.blogspot.com/2017/12/wsl-128-windowslinux.html)
- [【WSL】パスのフォーマットを変換する wslpath コマンドの使い方 – ラボラジアン](https://laboradian.com/wslpath-command-for-wsl/)
- [Cygwinでgo入門を諦めてWSL環境を作ったがCygwinでも大丈夫だった - exits](https://yuelab82.hatenablog.com/entry/go_on_cygwin_and_wsl)

### 5.3. Ubuntu

- [WSLのUbuntu環境を日本語化する：Tech TIPS - ＠IT](https://atmarkit.itmedia.co.jp/ait/articles/1806/28/news043.html)

### 5.4. zsh

- [zsh設定ファイル（.zshrc）を分割する - fnwiya's quine](http://fnwiya.hatenablog.com/entry/2015/11/03/191902)
- [【.zshrc解説】コピペで簡単zshカスタマイズ【設定方法】](https://suwaru.tokyo/【-zshrc解説】コピペで簡単zshカスタマイズ【設定方法/)
- [zshで大文字小文字を区別しないで補完 - Qiita](https://qiita.com/kenta4327/items/8faaa83f6a5bf595a4bc)
- [zshのプロンプトをカッコよくしてGitのブランチを表示させる | とみぃ研究所](https://tomiylab.com/2020/03/prompt/)
- [コマンドの実行結果を変数に代入](http://www.ajisaba.net/sh/var_command.html)
- [LinuxのOS名やバージョンを調べる（CentOS/Ubuntu） | pc.casey.jp](https://pc.casey.jp/archives/153904342)
- [bash/zshで16色(ANSI カラーコード)と256色のカラーパレットを表示 - よんちゅBlog](https://yonchu.hatenablog.com/entry/2012/10/20/044603)
- [Bashのif文でANDやOR条件、&&や||演算子を使う | 晴耕雨読](https://tex2e.github.io/blog/shell/bash-and-or)
- [シェルスクリプトの [ -a (AND) と -o (OR) ] は非推奨だかんね - Qiita](https://qiita.com/ko1nksm/items/6201b2ce47f4d6126521)

### 5.5. シェル関数

- acd 関数
    - [git コマンドで差分納品 zipを作る (かつ、不要ファイルは含めないようにしたい) ｜ Tips Note by TAM](https://www.tam-tam.co.jp/tipsnote/program/post12992.html)
    - 同僚の方のコード（ありがとうございました！！）
- cj 関数
    - [date コマンド | コマンドの使い方(Linux) | hydroculのメモ](https://hydrocul.github.io/wiki/commands/date.html)
    - [日付を取得する | UNIX & Linux コマンド・シェルスクリプト リファレンス](https://shellscript.sunone.me/date.html)
- moda 関数
    - [bashでコマンドが無い時にやる夫が動いて煽ってくるcommand_not_found_handle() | 俺的備忘録 〜なんかいろいろ〜](https://orebibou.com/ja/home/201810/20181005_001/)
    - [bash をウザくする - とりあえず暇だったし何となくはじめたブログ](https://khiker.hatenablog.jp/entry/20070814/bash_yaruo)

### 5.6. Git

- [最低限しておくといいgitconfigの設定 - Qiita](https://qiita.com/hayamofu/items/d8103e789196bcd8b489)
- [github/gitignore: A collection of useful .gitignore templates](https://github.com/github/gitignore)
- [gitignore に書くべきでないものは gitignore_global へ - Qiita](https://qiita.com/elzup/items/4c92a2abdab56db3fb4e)
- [gitignore_globalを作成する on OSX - Qiita](https://qiita.com/pira/items/dd67077c5b414c8eb59d)
- [.gitignoreに記載したのに反映されない件 - Qiita](https://qiita.com/fuwamaki/items/3ed021163e50beab7154)

### 5.7. Homebrew

- [dotfiles管理にhomebrew-bundleを導入する - Qiita](https://qiita.com/so-heee/items/351f0ea4e79196754e52)
- [Brew Bundleの使い方](https://gist.github.com/yoshimana/43b9205ddedad0ad65f2dee00c6f4261)

### 5.8. GCC

- [Windows10 でのC言語開発環境の作り方 - Qiita](https://qiita.com/fumigoro/items/a07f1e6f059ad4b2b3d2)
- [gccっていったいなんなんだ - Qiita](https://qiita.com/chihiro/items/1725f9dbb51942534641)

### 5.9. Node.js

- [WSL 2 上で Node.js を設定する | Microsoft Docs](https://docs.microsoft.com/ja-jp/windows/dev-environment/javascript/nodejs-on-wsl)

### 5.10. VSCode

- マークダウン
    - [自己流の手順書フォーマットを公開してみた | DevelopersIO](https://dev.classmethod.jp/articles/non-97-operation-manual/)
    - [【小ネタ】Visual Studio Code で Markdown All in One 機能拡張のインデントを 4 スペースに変更する | DevelopersIO](https://dev.classmethod.jp/articles/201906-vscode-markdown-customize-indent-size-settings/)
    - [markdownlint のインデント調整 - public note](https://ts223.hatenablog.com/entry/vscode-mdl)
    - [「markdownlint」を使ってメンテナブルなMarkdownを目指してみる - 憂鬱な世界にネコパンチ！](https://nekopunch.hatenablog.com/entry/2018/10/16/230529)
    - [VSCode の markdownlint プラグインを特定ルールを無視する設定を行う | らくがきちょう v3](https://sig9.org/archives/4456)
