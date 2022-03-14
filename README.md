<!-- omit in toc -->
# dotfiles

```shell
> cd
> git clone https://github.com/kenkenpa198/dotfiles.git
> source ~/dotfiles/.bin/sh/setup.sh
```

## 1. 概要

kenkenpa198 の dotfiles 。  
シンボリックリンクで色々つなげて、設定の変更を Git で検知して管理する。  

.gitignore をホワイトリスト形式にすることで、.gitignore で指定したファイルのみしか Git の管理下に入らないようにしている。  
こうすることで誤ってコミットしてしまうミスを防げる（なるほど～）。

## 2. 構築

1. 冒頭のコマンドを実行する。
2. その他シンボリックリンクなどを .setup 配下のスクリプトや README を参考に色々つなげる。

Windows 環境の場合は先に WSL2 の環境を構築することが必要。

## 3. Shell

```shell
.
├── .bashrc
├── .dircolors
├── .zsh
│   ├── alias.zsh
│   ├── option.zsh
│   ├── path.zsh
│   ├── theme.zsh
│   └── secret.zsh（Git 管理外）
└── .zshrc
```

シェル用の設定ファイル等を管理。

.zshrc へ .zsh ディレクトリ配下の `**.zsh` を読み込むコードを記述し、各設定ファイルを .zsh ディレクトリへ格納。  
zsh を起動した際に .zshrc へ読み込まれる（すごい）。  
同じような感じで .bashrc も alias.zsh を使いまわしている。

secret.zsh はトークンの環境変数等、セキュアな情報を記述したファイル。  
ホワイトリストには記述していないため Git 上には登録されない。  
未来の自分は環境を変えた時に移行し忘れないようにしてね！！！

## 4. Git

```shell
.
├── .gitconfig_shared
└── .gitignore_global
```

.gitconfig の基本設定やグローバルな除外設定を管理。

.gitignore_global を設定する前にコミットなどしちゃうとだいぶ面倒くさいので注意。  
やらかしたら下記コマンドでキャッシュを削除して改めてコミットする。

```shell
> git rm -r --cached .
```

.gitconfig の基本設定は .gitconfig_shared に切り分け、.gitignore_global と同様に .gitconfig へ外部読み込み設定を行うような運用にしている。  
.gitconfig にはメアドとユーザー名を記述する必要があり、Git 管理の対象にしたくなかったため。


## 5. Config

```shell
.
└── .config
     ├── Code
     .
     .
     .
     └── WSL2

```

.config ディレクトリ配下にはアプリごとの設定を保管している。  
それぞれシンボリックリンクを繋げる。

以下特記が必要なものを記載。

### 5.1. Code ディレクトリ

VSCode の設定ファイル用ディレクトリ。  
User 内のファイルを VSCode のディレクトリへシンボリックリンクとして配置する。

```shell
# Win
.setup/bat/

# Mac
> ln -sf ~/dotfiles/.config/Code/User/settings.json ~/Library/"Application Support"/Code/User/
> ln -sf ~/dotfiles/.config/Code/User/keybindings.json ~/Library/"Application Support"/Code/User/
> ln -sf ~/dotfiles/.config/Code/Markdown_Preview_Enhanced/style.less ~/.local/state/mume/
```

他に拡張機能の設定ファイルがあったら別個にディレクトリを作ってシンボリックリンクを繋げる。

### 5.2. Homebrew ディレクトリ

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

### 5.3. WindowsPowerShell ディレクトリ

PowerShell 用のエイリアス設定ファイル等を格納。  
mklink.bat に mklink コマンドを記載。

### 5.4. WindowsTerminal ディレクトリ

Windows Terminal 用の設定ファイルを格納。  
これもシンボリックリンクで繋げたいところだけど、繋げると読み込みに失敗してしまうようなのでコピペで対応。

WSL2 の GUID 設定を上書きしないよう注意。  
上書きしちゃったら `設定 > 新しいプロファイルを追加します > プロファイルを複製する` から該当のプロファイルを選んで複製 → 複製されたプロファイルの GUID で設定しなおす。

### 5.5. WSL2 ディレクトリ

格納されている .wslconfig は WSL2 そのものの設定ファイルのため、 WT と同様にシンボリックリンクで繋げると読み込みに失敗してしまう。  
そのため Win 環境のホームディレクトリへはファイルを複製して配置する。

## 6. Setup

```shell
├── .setup
     ├── bat
     │   ├── mklink.bat
     │   ├── setup_wsl.bat
     │   └── winget.bat
     └── sh
         ├── setup.sh
         ├── setup_bash_only.sh
         └── setup_docker.sh
```

セットアップ用のスクリプトファイル関連を保管。  
こちらを実行したり、記述を拾ったりしつつ環境を整える。

## 7. WSL2 の構築について

Win10 WSL2 環境の構築方法。  
alias などの記述は OS で判別し使い分けできるようにしている。

### 7.1. WSL 環境構築メモ

1. 参考にしたサイトを元に、Windows Terminal ～ zsh までインストールする。
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


## 8. 参考文献

### 8.1. dotfiles の構成

- [ようこそdotfilesの世界へ - Qiita](https://qiita.com/yutakatay/items/c6c7584d9795799ee164)
- [【初心者版】必要最小限のdotfilesを運用する - Qiita](https://qiita.com/ganariya/items/d9adffc6535dfca6784b)
- [gitignoreのホワイトリストの書き方 - Qiita](https://qiita.com/sventouz/items/574bd67c7e43fff10546)

### 8.2. zsh

- [zsh設定ファイル（.zshrc）を分割する - fnwiya's quine](http://fnwiya.hatenablog.com/entry/2015/11/03/191902)
- [【.zshrc解説】コピペで簡単zshカスタマイズ【設定方法】](https://suwaru.tokyo/【-zshrc解説】コピペで簡単zshカスタマイズ【設定方法/)
- [zshで大文字小文字を区別しないで補完 - Qiita](https://qiita.com/kenta4327/items/8faaa83f6a5bf595a4bc)
- [zshのプロンプトをカッコよくしてGitのブランチを表示させる | とみぃ研究所](https://tomiylab.com/2020/03/prompt/)

### 8.3. Git

- [最低限しておくといいgitconfigの設定 - Qiita](https://qiita.com/hayamofu/items/d8103e789196bcd8b489)
- [github/gitignore: A collection of useful .gitignore templates](https://github.com/github/gitignore)
- [gitignore に書くべきでないものは gitignore_global へ - Qiita](https://qiita.com/elzup/items/4c92a2abdab56db3fb4e)
- [gitignore_globalを作成する on OSX - Qiita](https://qiita.com/pira/items/dd67077c5b414c8eb59d)
- [.gitignoreに記載したのに反映されない件 - Qiita](https://qiita.com/fuwamaki/items/3ed021163e50beab7154)

### 8.4. Homebrew

- [dotfiles管理にhomebrew-bundleを導入する - Qiita](https://qiita.com/so-heee/items/351f0ea4e79196754e52)
- [Brew Bundleの使い方](https://gist.github.com/yoshimana/43b9205ddedad0ad65f2dee00c6f4261)

### 8.5. WSL2

- [Windows Terminal + WSL 2 + Homebrew + Zsh - Qiita](https://qiita.com/okayurisotto/items/36f6f9df499a74e62bff)
- [WSL その128 - Windowsの環境変数とLinuxの環境変数を相互に引き継ぎ可能に - kledgeb](https://kledgeb.blogspot.com/2017/12/wsl-128-windowslinux.html)
- [【WSL】パスのフォーマットを変換する wslpath コマンドの使い方 – ラボラジアン](https://laboradian.com/wslpath-command-for-wsl/)
- [Windows と Mac で開発環境を揃える Tips 集 - Neo's World](https://neos21.net/tech/windows-mac-environment.html)
- [Cygwinでgo入門を諦めてWSL環境を作ったがCygwinでも大丈夫だった - exits](https://yuelab82.hatenablog.com/entry/go_on_cygwin_and_wsl)

## 9. アーカイブ

もう使ってない設定のメモなどを記載。

### 9.1. iTerm2

iTerm2 用の設定ファイルを読込・出力するディレクトリ（今はもう削除した）。  
いちおう設定手順は下記。

1. Preferences > General タブ > Preferences タブ
2. Load preferenses from ... をチェック、パスの入力欄にローカルリポジトリのパスを指定。
3. Save Changes to ... を両方ともチェック。
