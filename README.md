# dotfiles
## 概要
わしの Mac ちゃその環境変数や設定のメモなどなどを管理する用リポジトリです！

## 使い方
1. ホームディレクトリに、本リポジトリを git clone 。
2. 元々ホームディレクトリに存在している .zshrc の代わりに、  
リポジトリ内の .zshrc をシンボリックリンクとしてホームディレクトリ直下に配置。
    ```
    % ln -s ~/dotfiles/.zshrc ~/
    ```
3. zsh を起動した際に、その .zshrc が読み込まれるようになる。
4. その他 .config 配下の設定ファイルなどもそれぞれシンボリックリンクで繋げる。
5. 環境変数の追加やアプリの設定変更があったら Git で検知されるので、ちまちまプッシュする。
### 参考
- [ようこそdotfilesの世界へ - Qiita](https://qiita.com/yutakatay/items/c6c7584d9795799ee164)
- [【初心者版】必要最小限のdotfilesを運用する - Qiita](https://qiita.com/ganariya/items/d9adffc6535dfca6784b)

## メモメモメリメロ
### .bin
スクリプトとかを格納するディレクトリ。とりあえずつくった。

---

### .config
アプリケーション関連の設定ファイルを格納するディレクトリ。  
アプリ個別の設定ファイルが格納されているディレクトリへ、それぞれシンボリックリンクで繋げる。
- Code
    - VSCode の設定ファイル用ディレクトリ。
    - 直下 User 内のファイルを VSCode のディレクトリへシンボリックリンクとして配置する。
        ```
        % ln -s ~/dotfiles/.config/Code/User/settings.json ~/Library/"Application Support"/Code/User/
        % ln -s ~/dotfiles/.config/Code/User/keybindings.json ~/Library/"Application Support"/Code/User/
        ```
- iTerm2
    - iTerm2 用の設定ファイルを読込・出力するディレクトリ。
    - iTerm2 の終了時にこのディレクトリへ設定を保存する設定にしている。
        - Preferences > General タブ > Preferences タブ
        - Load preferenses from ... をチェック、パスの入力欄にローカルリポジトリのパスを指定。
        - Save Changes to ... を両方ともチェック。 
- Homebrew
    - Homebrew の インストール済みアプリのリストファイル Brewfile を保管するディレクトリ。
    - brew bundle コマンドで保存・読込を行う。
        ```
        # リストの保存
        % brew bundle dump --force --file "~/dotfiles/.config/Homebrew/Brewfile"

        # リスト内容の確認
        # --all を —cask, —taps, —mas, --brews に変更で表示内容の指定
        % brew bundle list --all --force --file "~/dotfiles/.config/Homebrew/Brewfile"

        # 一括インストール
        % brew bundle --file "~/dotfiles/.config/Homebrew/Brewfile"
        ```

#### 参考
- [dotfiles管理にhomebrew-bundleを導入する - Qiita](https://qiita.com/so-heee/items/351f0ea4e79196754e52)
- [Brew Bundleの使い方](https://gist.github.com/yoshimana/43b9205ddedad0ad65f2dee00c6f4261)

---

### .zsh
.zshrc を小分けにしたファイルを格納するディレクトリ。  
子供を `**.zsh` という名称にすることで、zsh を起動した際に .zshrc へと読み込まれる。  
- secret.zsh
    - もだねちゃんのトークン等、セ±キュアなものを記述したファイル。
    - Git で除外するためホワイトリストには登録していない。
#### 参考
- [zsh設定ファイル（.zshrc）を分割する - fnwiya's quine](http://fnwiya.hatenablog.com/entry/2015/11/03/191902)
- [【.zshrc解説】コピペで簡単zshカスタマイズ【設定方法】](https://suwaru.tokyo/【-zshrc解説】コピペで簡単zshカスタマイズ【設定方法/)
- [zshで大文字小文字を区別しないで補完 - Qiita](https://qiita.com/kenta4327/items/8faaa83f6a5bf595a4bc)
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
Windows 用の設定も記述している（ブランチ切って別で作成したほうがいい希ガス） 。
- シンボリックリンクはホームディレクトリに作成し、git config で読込先として登録する。
    ```
    % ln -s ~/dotfiles/.gitignore_global ~/
    % git config --global core.excludesfile ~/.gitignore_global
    ```
#### 参考
- [github/gitignore: A collection of useful .gitignore templates](https://github.com/github/gitignore)
- [gitignore に書くべきでないものは gitignore_global へ - Qiita](https://qiita.com/elzup/items/4c92a2abdab56db3fb4e)
- [gitignore_globalを作成する on OSX - Qiita](https://qiita.com/pira/items/dd67077c5b414c8eb59d)

---

### install.sh
VSCode の拡張機能 Remote Containers で dotfiles を反映する時に用いるファイル。  
作成中。

#### 参考
- [VSCode Remote Containerが良い - Qiita](https://qiita.com/d0ne1s/items/d2649801c6f804019db7)
- [VSCode Remote Containersに自分のdotfilesを持ち込む - Kesinの知見置き場](http://kesin.hatenablog.com/entry/2020/07/10/083000)
