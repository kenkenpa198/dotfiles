# dotfiles
## 概要
わしの Mac ちゃその環境変数などなどを管理する用リポジトリです（楽しそうなのでやってみる）。  
ぐじゃぐじゃ書いていた環境変数を整理するのがめちゃ大変だった…。  
とりあえずひと段落着いたので色々整理していきたい！！！！！

## メモ
### 使い方
- シンボリックリンク
    - Mac のホームディレクトリに、本リポジトリを git clone 。
    - そして元々ホームディレクトリに存在している .zshrc の代わりに、リポジトリ内の .zshrc をシンボリックリンクとしてホームディレクトリ直下に配置（ `% ln -s ~/dotfiles/.zshrc ~` ）。
    - zsh を起動した際に、その .zshrc が読み込まれるようになる。
    - 後はなにかしら環境変数を変更した際に git push したり、新しいパソコンを買ったときに git clone したりと、設定を簡単に管理・引き継ぎすることができる。

### 内容
- .gitignore
    - ホワイトリスト形式で記述。
    - トークンや秘密鍵など Git 管理不可のファイル名等を除外する。
- .zsh
    - zshrc を小分けにしたファイルを格納するためのディレクトリ。
    - 子供を `***.zsh` という名称にすることで、zsh を起動した際に .zshrc へと読み込まれる。
    - alias.zsh secret.zsh など。

## 参考サイト
- [ようこそdotfilesの世界へ - Qiita](https://qiita.com/yutakatay/items/c6c7584d9795799ee164)
- [zsh設定ファイル（.zshrc）を分割する - fnwiya's quine](http://fnwiya.hatenablog.com/entry/2015/11/03/191902)
- [brew doctor したら Warning: "config" scripts exist outside your system or Homebrew directories.と出た時の解決法初心者的理解 - Qiita](https://qiita.com/yutoman027/items/ae11bf22bdbcd645c92a)
- [gitignoreのホワイトリストの書き方 - Qiita](https://qiita.com/sventouz/items/574bd67c7e43fff10546)
- [gitignore に書くべきでないものは gitignore_global へ - Qiita](https://qiita.com/elzup/items/4c92a2abdab56db3fb4e)
- [github/gitignore: A collection of useful .gitignore templates](https://github.com/github/gitignore)