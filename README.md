<!-- omit in toc -->
# dotfiles

```shell
> cd
> git clone https://github.com/kenkenpa198/dotfiles.git
> source ~/dotfiles/.setup/Linux/setup.sh
```

## 1. 概要

kenkenpa198 の dotfiles 。  
シンボリックリンクで色々つなげて、設定の変更を Git で検知して管理している。  

## 2. 構築方法

1. 冒頭のコマンドを実行してクローン & セットアップ。
2. その後シンボリックリンクなどを .setup 配下のスクリプトや README を参考に色々つなげる。

Windows 環境の場合は先に [WSL2 環境の構築](.documents/Install_WSL2.md) をしよう。  
その他補足資料やメモは [docs ディレクトリ](https://github.com/kenkenpa198/dotfiles/tree/main/docs) で管理。

## 3. 構成

dotfiles の構成を記載。

100% 自分用なのでわかりづらかったり整理できてなかったりするので注意。  
ほどよく名前順に記載しています。

### 3.1. bashrc / zshrc

```shell
.
├── .bashrc
├── .zsh
│   ├── .dircolors
│   └── rc
│       ├── alias.zsh
│       ├── func_*.zsh
│       ├── env.zsh
│       ├── option.zsh
│       ├── theme.zsh
│       └── secret.zsh（Git 管理外）
└── .zshrc
```

当 dotfiles の主人公である .zshrc と仲間たち。  

.zshrc へは .zsh ディレクトリ配下の `**.zsh` を読み込むコードのみを記述し、エイリアスなどは .zsh ディレクトリ配下の各設定ファイルへ分けて記述する。  
こうすることで、使い勝手は変わりないまま設定ファイルを整理することができる。

同じような感じで .bashrc も alias.zsh env.zsh を使いまわしている。

secret.zsh はトークンの環境変数等、セキュアな情報を記述したファイル。  
ホワイトリストには記述していないため Git 上には登録されない。  
未来の自分は環境を変えた時に移行し忘れないようにしてね！

頭に `func_` が付いているファイルは、alias.zsh から切り離した自作のシェル関数ファイル。  
それぞれの関数については [4. シェル関数](#4-シェル関数) セクションに記載。  
もっとファイルが増えてきそうだったら別ディレクトリで管理したい。

### 3.2. config

```shell
.
└── .config
     ├── ***
     └── ***
```

.config ディレクトリ配下には VSCode や Homebrew などアプリごとの設定ファイルを保管。  
基本的には各設定ファイルのコメントや [mklink.bat](.setup/bat/mklink.bat) などを参考にそれぞれシンボリックリンクを繋げる。

Windows Terminal の settings.json と WSL2 用の .wslconfig のみ、シンボリックリンクではなくコピペや複製で対応する。  
WSL2 が立ち上がる前に WSL2 内のファイルを読み込もうとして失敗してしまうようなため。

WSL2 の設定ファイルは GUID 設定を上書きしないよう注意。  
上書きしちゃったら `設定 > 新しいプロファイルを追加します > プロファイルを複製する` から該当のプロファイルを選んで複製 → 複製されたプロファイルの GUID で設定しなおす。

### 3.3. git

```shell
.
├── .gitconfig_shared
└── .gitignore_global
```

環境用の .gitconfig の基本設定やグローバルな除外設定を管理。

.gitignore_global を設定する前にコミットなどしちゃうと、コミット済みのファイルには適用されなくなるので注意。  
やらかしたら下記コマンドでキャッシュを削除して改めてコミットする。

```shell
> git rm -r --cached .
```

.gitconfig の基本設定は .gitconfig_shared に切り分け、.gitignore_global と同様に .gitconfig へ外部読み込み設定を行うような運用にしている。  
.gitconfig にはメアドとユーザー名を記述する必要があり、Git 管理の対象にしたくなかったため。

### 3.4. gitignore

```shell
.
└── .gitignore
```

当 dotfiles 用の .gitignore 。  

ホワイトリスト形式にすることで、.gitignore で指定したファイルのみしか Git の管理下に入らないようにしている。  
こうすることで誤ってコミットしてしまうミスを防げる。

### 3.5. setup

```shell
.
└── .setup
     ├── Linux
     │   ├── ***.sh
     │   └── ***.sh
     └── Windows
         ├── ***.bat
         └── ***.bat
```

セットアップ用のスクリプトファイル関連を保管。  
こちらを実行したり、記述を拾ったりしつつ環境を整える。

それぞれコマンドを単純に直書きしているだけなので、もう少しいい感じにしたい。

## 4. シェル関数

`.zsh/rc/` 配下に保存している自作の各シェル関数を紹介。

使ってみたい場合は内容をそのまま .bashrc などに記述してもらえれば動くと思います。  
それぞれ `-h` オプションでヘルプを表示します。

### 4.1. acd 関数

Git リポジトリ上で指定したコミット間の差分ファイルを ZIP 形式で出力する関数。  
指定にはコミット ID やブランチ名が使えます。  
名前は「Archive Commit Diff」の略。

example :

```shell
> acd main feature/add_tsukune
変更前のコミット : main
変更後のコミット : feature/add_tsukune

差分ファイルを出力しました。
archive.zip
```

### 4.2. cj 関数

CST（米国中部標準時）と JST（日本標準時）を計算して出力する関数。  
名前は「CST to JST」の略。

example :

```shell
> cj -c 'Sun, 22 Dec 2021 11:56:26'
Converted CST to JST.
--------------------------------
* CST: 2021-12-22 (Wed) 11:56:26
  JST: 2021-12-23 (Thu) 02:56:26
```

### 4.3. moda 関数

もだねちゃんが来てくれる関数。  
引数指定で大きくなったりアニメーションしたりします。

example :

```shell
> moda
   ( ),
\(^_^) moda!
```

## 5. 参考サイト

### 5.1. dotfiles

- [ようこそdotfilesの世界へ - Qiita](https://qiita.com/yutakatay/items/c6c7584d9795799ee164)
- [【初心者版】必要最小限のdotfilesを運用する - Qiita](https://qiita.com/ganariya/items/d9adffc6535dfca6784b)
- [gitignoreのホワイトリストの書き方 - Qiita](https://qiita.com/sventouz/items/574bd67c7e43fff10546)
- [Windows と Mac で開発環境を揃える Tips 集 - Neo's World](https://neos21.net/tech/windows-mac-environment.html)

### 5.2. Ubuntu

- [WSLのUbuntu環境を日本語化する：Tech TIPS - ＠IT](https://atmarkit.itmedia.co.jp/ait/articles/1806/28/news043.html)

### 5.3. zsh

- [zsh設定ファイル（.zshrc）を分割する - fnwiya's quine](http://fnwiya.hatenablog.com/entry/2015/11/03/191902)
- [【.zshrc解説】コピペで簡単zshカスタマイズ【設定方法】](https://suwaru.tokyo/【-zshrc解説】コピペで簡単zshカスタマイズ【設定方法/)
- [zshで大文字小文字を区別しないで補完 - Qiita](https://qiita.com/kenta4327/items/8faaa83f6a5bf595a4bc)
- [zshのプロンプトをカッコよくしてGitのブランチを表示させる | とみぃ研究所](https://tomiylab.com/2020/03/prompt/)

### 5.4. Git

- [最低限しておくといいgitconfigの設定 - Qiita](https://qiita.com/hayamofu/items/d8103e789196bcd8b489)
- [github/gitignore: A collection of useful .gitignore templates](https://github.com/github/gitignore)
- [gitignore に書くべきでないものは gitignore_global へ - Qiita](https://qiita.com/elzup/items/4c92a2abdab56db3fb4e)
- [gitignore_globalを作成する on OSX - Qiita](https://qiita.com/pira/items/dd67077c5b414c8eb59d)
- [.gitignoreに記載したのに反映されない件 - Qiita](https://qiita.com/fuwamaki/items/3ed021163e50beab7154)

### 5.5. Homebrew

- [dotfiles管理にhomebrew-bundleを導入する - Qiita](https://qiita.com/so-heee/items/351f0ea4e79196754e52)
- [Brew Bundleの使い方](https://gist.github.com/yoshimana/43b9205ddedad0ad65f2dee00c6f4261)

### 5.6. GCC

- [Windows10 でのC言語開発環境の作り方 - Qiita](https://qiita.com/fumigoro/items/a07f1e6f059ad4b2b3d2)
- [gccっていったいなんなんだ - Qiita](https://qiita.com/chihiro/items/1725f9dbb51942534641)

### 5.7. Node.js

- [WSL 2 上で Node.js を設定する | Microsoft Docs](https://docs.microsoft.com/ja-jp/windows/dev-environment/javascript/nodejs-on-wsl)
