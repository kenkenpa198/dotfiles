<!-- omit in toc -->
# dotfiles

```shell
cd
git clone git@github.com:kenkenpa198/dotfiles.git
bash ~/dotfiles/setup/Ubuntu/[script-name.sh]
```

<!-- omit in toc -->
## 目次

- [構築手順](#構築手順)
- [dotfiles の構成](#dotfiles-の構成)
    - [bin/](#bin)
    - [config/](#config)
    - [setup/](#setup)
    - [zsh/ と .zshrc](#zsh-と-zshrc)
    - [.gitignore\_shared と .gitignore\_global](#gitignore_shared-と-gitignore_global)
- [補足](#補足)
    - [ホワイトリスト形式の .gitignore](#ホワイトリスト形式の-gitignore)
    - [Git のキャッシュ削除手順](#git-のキャッシュ削除手順)
    - [PowerShell でスクリプトを実行する](#powershell-でスクリプトを実行する)
    - [Windows Terminal の GUID 復元手順](#windows-terminal-の-guid-復元手順)
- [参考文献](#参考文献)
    - [dotfiles 全般](#dotfiles-全般)
    - [WSL](#wsl)
    - [Ubuntu](#ubuntu)
    - [zsh](#zsh)
    - [シェルスクリプト・シェル関数](#シェルスクリプトシェル関数)
    - [Git](#git)
    - [Homebrew](#homebrew)
    - [GCC](#gcc)
    - [Node.js](#nodejs)
    - [VS Code](#vs-code)
    - [PowerShell](#powershell)

## 構築手順

1. Windows 環境の場合、次の対応を行っておく。
    1. PowerShell を管理者権限で起動する。
    2. WSL をインストールする。

        ```powershell
        wsl --install
        ```

        参考: [WSL のインストール | Microsoft Learn](https://learn.microsoft.com/ja-jp/windows/wsl/install)

    3. SSH キーの作成と GitHub アカウントへ公開鍵の登録を行う（`git clone my-git-repositories` に必要）。
    4. Win 環境側でイーサネットアダプターの IPv6 を無効にする（`sudo apt-add-repository ppa:foo/bar` に必要）。
2. ホームディレクトリ上で冒頭のコマンドを実行して dotfiles をクローン & Ubuntu 環境のセットアップ。
3. [setup/](setup) 配下のスクリプトを使用してシンボリックリンクを各ディレクトリへ配置する。

## dotfiles の構成

### bin/

```shell
.
└── bin
     ├── ***
     └── ***
```

`bin/` ディレクトリには自作コマンドを格納している。

それぞれ実行権限の付与と `~/bin/` 配下へのシンボリックリンク作成を行っておく。

```shell
chmod +x moda
sudo ln -sf ~/dotfiles/bin/moda ~/bin/
```

[install-my-scripts.sh](setup/Ubuntu/install-my-scripts.sh) を実行すると、上記の設定をすべてのファイルに対して実行できるようにしている。

```shell
bash ~/dotfiles/setup/Ubuntu/install-my-scripts.sh
```

### config/

```shell
.
└── config
     ├── ***
     └── ***
```

`config/` ディレクトリ配下には VS Code などアプリごとの設定ファイルを保管している。

基本的には各設定ファイルのコメントや [setup/](setup) 配下のファイルを参考にしたり実行してそれぞれシンボリックリンクを繋げる。

PowerShell で `***.ps1` ファイルを実行する場合、実行ポリシーの変更が必要なため適宜実行しておく。補足を参照。

Windows Terminal の `settings.json` と WSL 用の `.wslconfig` のみ、シンボリックリンクではなくコピペや複製で対応する。WSL が立ち上がる前に WSL 内のファイルを読み込もうとして失敗してしまうようなため。

WSL と Windows の二環境を考慮しないといけない分、いろいろと面倒くさい。下記も参考に。

- [PowerShell でスクリプトを実行する](#powershell-でスクリプトを実行する)
- [Windows Terminal の GUID 復元手順](#windows-terminal-の-guid-復元手順)

### setup/

```shell
.
└── setup
     ├── MacOS
     │   └── Brewfile
     ├── Ubuntu
     │   ├── ***.sh
     │   └── ***.sh
     └── Windows
         ├── ***.ps1
         └── ***.ps1
```

`setup/` 配下にはセットアップ用のスクリプトファイルやインストールするアプリケーションなどを管理している。

これらを実行したり、記述を拾ったりしつつ環境を整える。

### zsh/ と .zshrc

```shell
.
├── zsh
│   └── rc
│       ├── alias.zsh
│       ├── env.zsh
│       ├── option.zsh
│       ├── secret.zsh（Git 管理外）
│       └── theme.zsh
└── .zshrc
```

zsh の設定ファイル群。

ホームディレクトリへのシンボリックリンク設定は `.zshrc` のみ行う。

`.zshrc` へは `zsh/rc/` ディレクトリ配下の `**.zsh` を読み込むコードのみを記述し、環境変数やエイリアスの設定を記述したファイルを `zsh/rc/` 配下へ配置する。こうすることで設定ファイルを分割して整理することができる。

`secret.zsh` はセキュアな環境変数や環境依存の設定などを記述したファイル。後述のホワイトリストには記述していないため Git では追跡されない。未来の自分は環境を変えた時に移行し忘れないように！

`zsh/` 配下でわざわざ `rc/` ディレクトリを切っているのは、 [`.dircolors` を `zsh/` 配下で運用していたころの名残](https://github.com/kenkenpa198/dotfiles/commit/b7d88caf0a1c97a0517137e94ea0a9679906be54) 。今後に備えてとりあえずそのままにしている。

### .gitignore_shared と .gitignore_global

```shell
.
├── .gitconfig_shared
└── .gitignore_global
```

作業環境用の `.gitconfig` の基本設定やグローバルな除外設定を管理。

インストール用スクリプトにて下記のコマンドを実行し、`.gitconfig` から読み込みを行うようにしている。

```shell
# .gitconfig へ .gitconfig_global を読み込み設定
git config --global core.excludesfile ~/.gitignore_global

# .gitconfig へ .gitconfig_shared を外部読み込み設定
git config --global include.path ~/.gitconfig_shared
```

上記のとおり、`.gitconfig` を直接管理するのではなく `.gitconfig_shared` に切り分けて外部読み込みを行う運用にしている。`.gitconfig` には Git のユーザー名とメールアドレスを記述する必要があり、Git 管理の対象にしたくなかったため。

## 補足

### ホワイトリスト形式の .gitignore

```shell
.
└── .gitignore
```

当 dotfiles 用の `.gitignore` はホワイトリスト形式での記述を行い、`.gitignore` で指定したファイルのみしか Git の管理下に入らないようにしている。

こうすることで、新しく追加したファイルに秘匿すべき情報が含まれていた際に、誤ってコミットしてしまうミスを防げる。

### Git のキャッシュ削除手順

- `.gitignore_global` を設定する前にコミットをしてしまった。
- 過去に追跡対象としてコミットしたファイルを `.gitignore` で追跡対象外にしたい。
- `.gitignore` を整理したので追跡対象の設定が問題ないか確認したい。

これらに該当する場合は、Git のキャッシュ削除が必要になる。

次のコマンドを順に実行して対応する。

```shell
# cd
cd ~/dotfiles

# Git のキャッシュをすべてのファイルから削除する
git rm --cached -r .

# 全てのファイルをステージングする
git add -vA

# コミット対象のファイルが変更を加えたファイルのみであるか確認する
git status -s

# コミットする
git commit -m '[commit comments]'
```

### PowerShell でスクリプトを実行する

PowerShell はネットワークから取得したスクリプトファイル `***.ps1` がデフォルトで実行できない。このため、スクリプトの実行前に実行ポリシーの変更が必要となる。

一時的に実行ポリシーを変更する場合は下記の手順で行う。

1. 管理者権限で PowerShell を実行する。
2. 現在の実行ポリシーを確認する。

    ```powershell
    # 実行ポリシーを確認する
    > Get-ExecutionPolicy
    Restricted # 既定の実行ポリシー。構成ファイルのロードやスクリプトの実行が行えない
    ```

3. 実行ポリシーを一時的に変更する。

    ```powershell
    # その時のプロセスでのみ有効にする
    # Set-ExecutionPolicy -ExecutionPolicy [実行ポリシー] -Scope [スコープ]
    # RemoteSigned ... 署名されたスクリプトが実行できる実行ポリシー
    # Process      ... 実行ポリシーを現在の PowerShell プロセスのみに影響させる
    > Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process

    実行ポリシーの変更
    実行ポリシーは、信頼されていないスクリプトからの保護に役立ちます。実行ポリシーを変更すると、about_Execution_Policies のヘルプ トピック
    (https://go.microsoft.com/fwlink/?LinkID=135170) で説明されているセキュリティ上の危険にさらされる可能性があります。実行ポリシーを変更しますか?
    [Y] はい(Y)  [A] すべて続行(A)  [N] いいえ(N)  [L] すべて無視(L)  [S] 中断(S)  [?] ヘルプ (既定値は "N"): y

    # 確認する
    > Get-ExecutionPolicy
    RemoteSigned

    # スクリプトを実行する
    > hoge.ps1
    ```

### Windows Terminal の GUID 復元手順

Windows Terminal の設定ファイルを上書きする際、環境によっては WSL を Windows Terminal で実行できなくなる場合がある。Ubuntu のバージョンに紐づけられた GUID が上書き前後で変わってしまったため。（※ 理解が正確でないかも）

この場合、下記の手順で上書き前の GUID を復元する。

1. `Ctrl + ,` で設定を開く。
2. `新しいプロファイルを追加します` を選択する。
3. `プロファイルを複製する` から `Ubuntu` など目的のプロファイルを選んで `複製` をクリックする。
4. 複製されたプロファイルの GUID を既存のプロファイルへ記述する。

## 参考文献

### dotfiles 全般

- [ようこそdotfilesの世界へ - Qiita](https://qiita.com/yutakatay/items/c6c7584d9795799ee164)
- [【初心者版】必要最小限のdotfilesを運用する - Qiita](https://qiita.com/ganariya/items/d9adffc6535dfca6784b)
- [gitignoreのホワイトリストの書き方 - Qiita](https://qiita.com/sventouz/items/574bd67c7e43fff10546)
- [Windows と Mac で開発環境を揃える Tips 集 - Neo's World](https://neos21.net/tech/windows-mac-environment.html)

### WSL

- [WSL のインストール | Microsoft Docs](https://docs.microsoft.com/ja-jp/windows/wsl/install)
- [Windows Terminal + WSL 2 + Homebrew + Zsh - Qiita](https://qiita.com/okayurisotto/items/36f6f9df499a74e62bff)
- [windows10でVSCode+WSL2(Ubuntu)+Docker Desktopの開発環境を作る](https://zenn.dev/ivgtr/scraps/92e14f80683be9)
- [WSL その128 - Windowsの環境変数とLinuxの環境変数を相互に引き継ぎ可能に - kledgeb](https://kledgeb.blogspot.com/2017/12/wsl-128-windowslinux.html)
- [【WSL】パスのフォーマットを変換する wslpath コマンドの使い方 – ラボラジアン](https://laboradian.com/wslpath-command-for-wsl/)
- [Cygwinでgo入門を諦めてWSL環境を作ったがCygwinでも大丈夫だった - exits](https://yuelab82.hatenablog.com/entry/go_on_cygwin_and_wsl)

### Ubuntu

- [WSLのUbuntu環境を日本語化する：Tech TIPS - ＠IT](https://atmarkit.itmedia.co.jp/ait/articles/1806/28/news043.html)

### zsh

- [zsh設定ファイル（.zshrc）を分割する - fnwiya's quine](http://fnwiya.hatenablog.com/entry/2015/11/03/191902)
- [【.zshrc解説】コピペで簡単zshカスタマイズ【設定方法】](https://suwaru.tokyo/【-zshrc解説】コピペで簡単zshカスタマイズ【設定方法/)
- [zshで大文字小文字を区別しないで補完 - Qiita](https://qiita.com/kenta4327/items/8faaa83f6a5bf595a4bc)
- [zshのプロンプトをカッコよくしてGitのブランチを表示させる | とみぃ研究所](https://tomiylab.com/2020/03/prompt/)
- [コマンドの実行結果を変数に代入](http://www.ajisaba.net/sh/var_command.html)
- [LinuxのOS名やバージョンを調べる（CentOS/Ubuntu） | pc.casey.jp](https://pc.casey.jp/archives/153904342)
- [bash/zshで16色(ANSI カラーコード)と256色のカラーパレットを表示 - よんちゅBlog](https://yonchu.hatenablog.com/entry/2012/10/20/044603)
- [Bashのif文でANDやOR条件、&&や||演算子を使う | 晴耕雨読](https://tex2e.github.io/blog/shell/bash-and-or)
- [シェルスクリプトの \[ -a (AND) と -o (OR) \] は非推奨だかんね - Qiita](https://qiita.com/ko1nksm/items/6201b2ce47f4d6126521)

### シェルスクリプト・シェル関数

- [シェルスクリプトを高級言語のような書き味に近づける Tips 集](https://sousaku-memo.net/php-system/1817)
- [使いやすいシェルスクリプトを書く | Taichi Nakashima](https://deeeet.com/writing/2014/05/18/shell-template/)
- [初心者向け、「上手い」シェルスクリプトの書き方メモ - Qiita](https://qiita.com/m-yamashita/items/889c116b92dc0bf4ea7d)
- [bashのヒアドキュメントを活用する - Qiita](https://qiita.com/take4s5i/items/e207cee4fb04385a9952)

### Git

- [最低限しておくといいgitconfigの設定 - Qiita](https://qiita.com/hayamofu/items/d8103e789196bcd8b489)
- [github/gitignore: A collection of useful .gitignore templates](https://github.com/github/gitignore)
- [gitignore に書くべきでないものは gitignore_global へ - Qiita](https://qiita.com/elzup/items/4c92a2abdab56db3fb4e)
- [gitignore_globalを作成する on OSX - Qiita](https://qiita.com/pira/items/dd67077c5b414c8eb59d)
- [.gitignoreに記載したのに反映されない件 - Qiita](https://qiita.com/fuwamaki/items/3ed021163e50beab7154)

### Homebrew

- [dotfiles管理にhomebrew-bundleを導入する - Qiita](https://qiita.com/so-heee/items/351f0ea4e79196754e52)
- [Brew Bundleの使い方](https://gist.github.com/yoshimana/43b9205ddedad0ad65f2dee00c6f4261)

### GCC

- [Windows10 でのC言語開発環境の作り方 - Qiita](https://qiita.com/fumigoro/items/a07f1e6f059ad4b2b3d2)
- [gccっていったいなんなんだ - Qiita](https://qiita.com/chihiro/items/1725f9dbb51942534641)

### Node.js

- [WSL 2 上で Node.js を設定する | Microsoft Docs](https://docs.microsoft.com/ja-jp/windows/dev-environment/javascript/nodejs-on-wsl)

### VS Code

- Markdown
    - [自己流の手順書フォーマットを公開してみた | DevelopersIO](https://dev.classmethod.jp/articles/non-97-operation-manual/)
    - [【小ネタ】Visual Studio Code で Markdown All in One 機能拡張のインデントを 4 スペースに変更する | DevelopersIO](https://dev.classmethod.jp/articles/201906-vscode-markdown-customize-indent-size-settings/)
    - [markdownlint のインデント調整 - public note](https://ts223.hatenablog.com/entry/vscode-mdl)
    - [「markdownlint」を使ってメンテナブルなMarkdownを目指してみる - 憂鬱な世界にネコパンチ！](https://nekopunch.hatenablog.com/entry/2018/10/16/230529)
    - [VSCode の markdownlint プラグインを特定ルールを無視する設定を行う | らくがきちょう v3](https://sig9.org/archives/4456)

### PowerShell

- [実行ポリシーについて - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.3)
- [Set-ExecutionPolicy (Microsoft.PowerShell.Security) - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-7.3)
- [PowerShellでこのシステムではスクリプトの実行が無効になっているため、ファイル hoge.ps1 を読み込むことができません。となったときの対応方法 - Qiita](https://qiita.com/ponsuke0531/items/4629626a3e84bcd9398f)
- [PowerShellの.bashrc的な設定ファイルこと$Profileについての紹介 - Qiita](https://qiita.com/smicle/items/0ca4e6ae14ea92000d18)
