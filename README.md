# dotfiles
## 概要
わしの Mac ちゃその環境変数や設定のメモなどなどを管理する用リポジトリです！

## 使い方
1. ホームディレクトリに、本リポジトリを git clone 。
2. 元々ホームディレクトリに存在している .zshrc の代わりに、  
リポジトリ内の .zshrc をシンボリックリンクとしてホームディレクトリ直下に配置。
    - コマンド：`% ln -s ~/dotfiles/.zshrc ~`
3. zsh を起動した際に、その .zshrc が読み込まれるようになる。
4. .config などアプリの設定ファイルもそれぞれシンボリックリンクで繋げる。
5. 環境変数の追加やアプリの設定変更があったら Git で検知されるので、ちまちまプッシュする。
### 参考
- [ようこそdotfilesの世界へ - Qiita](https://qiita.com/yutakatay/items/c6c7584d9795799ee164)

## メモメモメリメロ
### .bin
スクリプトとかを格納するディレクトリ。とりあえずつくった。

---

### .config
アプリケーション関連の設定ファイルを格納するディレクトリ。  
アプリ個別の設定ファイルが格納されているディレクトリへ、それぞれシンボリックリンクで繋げる。
- Code
    - VSCode 用の設定ファイル。
    - 格納先：`$HOME/Library/Application Support/Code/User`
- 
- 

---

### .zsh
.zshrc を小分けにしたファイルを格納するディレクトリ。  
子供を `***.zsh` という名称にすることで、zsh を起動した際に .zshrc へと読み込まれる。  
- alias.zsh
- secret.zsh
    - もだねちゃんのトークン等、セキュアなものを記述したファイル。
    - Git で除外するためホワイトリストには登録していない。
#### 参考
- [zsh設定ファイル（.zshrc）を分割する - fnwiya's quine](http://fnwiya.hatenablog.com/entry/2015/11/03/191902)

---

### .gitignore
本リポジトリ用の Git 除外設定を**ホワイトリスト形式**で記述。  
Git 管理不可のファイル名は記述しないようにする。

#### 参考
- [gitignoreのホワイトリストの書き方 - Qiita](https://qiita.com/sventouz/items/574bd67c7e43fff10546)

---

### .gitignore_global
グローバルな .gitignore 。  
Win でも使えるように Windows 用の設定も記述している。
#### コマンドメモ
- 登録：`% git config --global core.excludesfile ~/.gitignore_global`
#### 参考
- [github/gitignore: A collection of useful .gitignore templates](https://github.com/github/gitignore)
    - このリポジトリの記述をまるまるコピペさせてもらっている。
- [gitignore に書くべきでないものは gitignore_global へ - Qiita](https://qiita.com/elzup/items/4c92a2abdab56db3fb4e)
- [gitignore_globalを作成する on OSX - Qiita](https://qiita.com/pira/items/dd67077c5b414c8eb59d)

---

### Homebrew
ついでにいろいろメモ 🍺

#### 参考
- [brew doctor したら Warning: "config" scripts exist outside your system or Homebrew directories.と出た時の解決法初心者的理解 - Qiita](https://qiita.com/yutoman027/items/ae11bf22bdbcd645c92a)