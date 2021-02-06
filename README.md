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
    - VSCode の設定ファイル用ディレクトリ。直下の User 内のファイルをシンボリックリンク。
    - 格納先：`$HOME/Library/Application Support/Code/User`
- iTerm2
    - iTerm2 用の設定ファイルを保管するディレクトリ。
    - iTerm2 の終了時にこのディレクトリへ設定を保存する。
        - 設定箇所：Preferences... > General > Preferences
        - Load preferenses from ... と Save Changes to ... を両方ともチェック。
        - パスの入力欄にローカルリポジトリのパスを指定。
- 

---

### .zsh
.zshrc を小分けにしたファイルを格納するディレクトリ。  
子供を `***.zsh` という名称にすることで、zsh を起動した際に .zshrc へと読み込まれる。  
- secret.zsh
    - もだねちゃんのトークン等、セキュアなものを記述したファイル。
    - Git で除外するためホワイトリストには登録していない。
#### 参考
- [zsh設定ファイル（.zshrc）を分割する - fnwiya's quine](http://fnwiya.hatenablog.com/entry/2015/11/03/191902)
- [【.zshrc解説】コピペで簡単zshカスタマイズ【設定方法】](https://suwaru.tokyo/【-zshrc解説】コピペで簡単zshカスタマイズ【設定方法/)
- [zshのプロンプトをカッコよくしてGitのブランチを表示させる | とみぃ研究所](https://tomiylab.com/2020/03/prompt/)

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

### install.sh
VSCode の Remote Containers で dotfiles を反映する時に用いるファイル。  
作成中。

#### 参考
- [VSCode Remote Containerが良い - Qiita](https://qiita.com/d0ne1s/items/d2649801c6f804019db7)
- [VSCode Remote Containersに自分のdotfilesを持ち込む - Kesinの知見置き場](http://kesin.hatenablog.com/entry/2020/07/10/083000)