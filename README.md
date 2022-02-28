<!-- omit in toc -->
# dotfiles

## 1. 概要

設定とかいろいろ保管しておくリポジトリだよ。

### 1.1. 使い方

1. ホームディレクトリに、本リポジトリを git clone 。
2. 元々ホームディレクトリに存在している .zshrc の代わりに、  
リポジトリ内の .zshrc 等をシンボリックリンクとしてホームディレクトリ直下に配置。

    ```shell
    > ln -sf ~/dotfiles/.zshrc ~/
    ```

3. zsh を起動した際に、その .zshrc が読み込まれるようになる。
4. その他 .config 配下の設定ファイルなどもそれぞれシンボリックリンクで繋げる。
5. 環境変数の追加やアプリの設定変更があったら Git で検知されるので、ちまちまプッシュする。

#### 1.1.1. 参考にしたサイト

- [ようこそdotfilesの世界へ - Qiita](https://qiita.com/yutakatay/items/c6c7584d9795799ee164)
- [【初心者版】必要最小限のdotfilesを運用する - Qiita](https://qiita.com/ganariya/items/d9adffc6535dfca6784b)

## 2. シェル設定関連

.zshrc 用のファイルを .zsh ディレクトリ以下に格納。

.zshrc へ読み込みに関する設定値を記述しておいた上で .zshrc を小分けにしたファイルを .zsh ディレクトリへ格納している。  
子供を `**.zsh` という名称にすることで、zsh を起動した際に .zshrc へと読み込まれる。  

### 2.1. secret.zsh

もだねちゃんのトークン等、セキュアなものを記述したファイル。
ホワイトリストには登録していないためGit上には登録されない。

未来の自分は環境変えた時に移行し忘れないようにしてね。

#### 2.1.1. 参考にしたサイト

- [zsh設定ファイル（.zshrc）を分割する - fnwiya's quine](http://fnwiya.hatenablog.com/entry/2015/11/03/191902)
- [【.zshrc解説】コピペで簡単zshカスタマイズ【設定方法】](https://suwaru.tokyo/【-zshrc解説】コピペで簡単zshカスタマイズ【設定方法/)
- [zshで大文字小文字を区別しないで補完 - Qiita](https://qiita.com/kenta4327/items/8faaa83f6a5bf595a4bc)
- [zshのプロンプトをカッコよくしてGitのブランチを表示させる | とみぃ研究所](https://tomiylab.com/2020/03/prompt/)

## 3. Git 設定関連

Git に関する設定。ディレクトリは今の所直下。  
設定する前にコミットなどしちゃうと面倒くさいので早めに設定しておく。

### 3.1. .gitignore

本リポジトリ用の Git 除外設定を**ホワイトリスト形式**で記述。  
Git 管理不可のファイル名は記述しないようにする。

#### 3.1.1. 参考にしたサイト

- [gitignoreのホワイトリストの書き方 - Qiita](https://qiita.com/sventouz/items/574bd67c7e43fff10546)

### 3.2. .gitignore_global

グローバルな .gitignore 。
シンボリックリンクはホームディレクトリに作成し、git config で読込先として登録する。

```shell
> ln -sf ~/dotfiles/.gitignore_global ~/                    # シンボリックリンクを作成
> git config --global core.excludesfile ~/.gitignore_global # git config へ設定
```

誤って .gitignore_global を設定する前にコミットしたりしてキャッシュが作成された場合は  
dotfiles ディレクトリ上で下記を実行してキャッシュをクリアする。

```shell
> git rm -r --cached .
```

#### 3.2.1. 参考にしたサイト

- [github/gitignore: A collection of useful .gitignore templates](https://github.com/github/gitignore)
- [gitignore に書くべきでないものは gitignore_global へ - Qiita](https://qiita.com/elzup/items/4c92a2abdab56db3fb4e)
- [gitignore_globalを作成する on OSX - Qiita](https://qiita.com/pira/items/dd67077c5b414c8eb59d)
- [.gitignoreに記載したのに反映されない件 - Qiita](https://qiita.com/fuwamaki/items/3ed021163e50beab7154)

## 4. アプリ設定関連

.config ディレクトリより以下にアプリごとの設定を保管。
それぞれシンボリックリンクを繋げる。

### 4.1. Homebrew

Homebrew の インストール済みアプリのリストファイル Brewfile を保管するディレクトリ。  
brew bundle コマンドで保存・読込を行う。

```shell
# リストの保存
> brew bundle dump --force --file "~/dotfiles/.config/Homebrew/Brewfile"

# リスト内容の確認
# --all を —cask, —taps, —mas, --brews に変更で表示内容の指定
> brew bundle list --all --force --file "~/dotfiles/.config/Homebrew/Brewfile"

# 一括インストール
> brew bundle --file "~/dotfiles/.config/Homebrew/Brewfile"
```

#### 4.1.1. 参考にしたサイト

- [dotfiles管理にhomebrew-bundleを導入する - Qiita](https://qiita.com/so-heee/items/351f0ea4e79196754e52)
- [Brew Bundleの使い方](https://gist.github.com/yoshimana/43b9205ddedad0ad65f2dee00c6f4261)

### 4.2. Code

VSCode の設定ファイル用ディレクトリ。  
直下 User 内のファイルを VSCode のディレクトリへシンボリックリンクとして配置する。

```shell
# VSC の標準設定系
> ln -sf ~/dotfiles/.config/Code/User/settings.json ~/Library/"Application Support"/Code/User/
> ln -sf ~/dotfiles/.config/Code/User/keybindings.json ~/Library/"Application Support"/Code/User/

# Markdown Preview Enhanced
> ln -sf ~/dotfiles/.config/Code/Markdown_Preview_Enhanced/style.less ~/.local/state/mume/
```

### 4.3. iTerm2

iTerm2 用の設定ファイルを読込・出力するディレクトリ。  
iTerm2 の終了時にこのディレクトリへ設定を保存する設定にしている。
設定手順は下記。（今はもう使ってない）

1. Preferences > General タブ > Preferences タブ
2. Load preferenses from ... をチェック、パスの入力欄にローカルリポジトリのパスを指定。
3. Save Changes to ... を両方ともチェック。

### 4.4. Windows PowerShell

PowerShell 用のエイリアス設定ファイル等を格納。

### 4.5. Windows Terminal

WSL 環境で用いる WT 用の設定ファイルを格納。

## 5. スクリプト関連

.bin ディレクトリにはスクリプトなどを格納する。

### 5.1. install_rc.sh

VSCode の拡張機能 Remote Containers で dotfiles を反映する時に用いるファイル。調整中でそのまま放置。

#### 5.1.1. 参考にしたサイト

- [VSCode Remote Containerが良い - Qiita](https://qiita.com/d0ne1s/items/d2649801c6f804019db7)
- [VSCode Remote Containersに自分のdotfilesを持ち込む - Kesinの知見置き場](http://kesin.hatenablog.com/entry/2020/07/10/083000)

## 6. その他

### 6.1. WSL の構築について

Win10 WSL 環境の構築方法。  
alias などの記述は OS で判別し使い分けできるようにしている。

#### 6.1.1. WSL 環境構築メモ

1. 参考にしたサイト URL を元に、Windows Terminal ～ zsh までインストールする。
2. dotfiles を clone する。
3. .zshrc 等のシンボリックリンクを作成して読み込む。
4. Win10 の GUI から環境変数へ下記を追加する。

    ```text
    変数名：WSLENV
    変数値：Path/pu:USERPROFILE/pu
    ```

5. Shell を再起動し、エクスプローラー等が zsh 上で使えるか確認する。

    ```shell
    > explorer.exe .
    > code .
    ```

#### 6.1.2. 参考にしたサイト

- [Windows Terminal + WSL 2 + Homebrew + Zsh - Qiita](https://qiita.com/okayurisotto/items/36f6f9df499a74e62bff)
- [WSL その128 - Windowsの環境変数とLinuxの環境変数を相互に引き継ぎ可能に - kledgeb](https://kledgeb.blogspot.com/2017/12/wsl-128-windowslinux.html)
- [【WSL】パスのフォーマットを変換する wslpath コマンドの使い方 – ラボラジアン](https://laboradian.com/wslpath-command-for-wsl/)
- [Windows と Mac で開発環境を揃える Tips 集 - Neo's World](https://neos21.net/tech/windows-mac-environment.html)
- [Cygwinでgo入門を諦めてWSL環境を作ったがCygwinでも大丈夫だった - exits](https://yuelab82.hatenablog.com/entry/go_on_cygwin_and_wsl)
