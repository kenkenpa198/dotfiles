<!-- omit in toc -->
# dotfiles

```shell
cd
git clone git@github.com:kenkenpa198/dotfiles.git
bash ~/dotfiles/setup/ubuntu/setup.sh
```

<!-- omit in toc -->
## TOC

- [1. Setup](#1-setup)
    - [1.1. for WSL (Ubuntu)](#11-for-wsl-ubuntu)
    - [1.2. for Windows](#12-for-windows)
    - [1.3. for MacOS](#13-for-macos)
- [2. Tips](#2-tips)
    - [2.1. ホワイトリスト形式の .gitignore](#21-ホワイトリスト形式の-gitignore)
    - [2.2. Git のキャッシュ削除手順](#22-git-のキャッシュ削除手順)
    - [2.3. PowerShell でスクリプトを実行する](#23-powershell-でスクリプトを実行する)
    - [2.4. Windows Terminal の GUID 復元手順](#24-windows-terminal-の-guid-復元手順)
- [3. Reference](#3-reference)

## 1. Setup

### 1.1. for WSL (Ubuntu)

1. PowerShell を管理者権限で起動する。
2. WSL をインストールしてセットアップする。

    ```powershell
    wsl --install
    ```

    参考: [WSL のインストール | Microsoft Learn](https://learn.microsoft.com/ja-jp/windows/wsl/install)

3. SSH キーの作成と GitHub アカウントへ公開鍵の登録を行う。
4. ホームディレクトリ上で README 冒頭のコマンドを実行して dotfiles をクローン & Ubuntu 環境のセットアップ。

### 1.2. for Windows

[2.3. PowerShell でスクリプトを実行する](#23-powershell-でスクリプトを実行する) の手順を元に [setup/windows](setup/windows) 配下のスクリプトを実行する。

### 1.3. for MacOS

その内書く

## 2. Tips

### 2.1. ホワイトリスト形式の .gitignore

```shell
.
└── .gitignore
```

当 dotfiles 用の `.gitignore` はホワイトリスト形式での記述を行い、`.gitignore` で指定したファイルのみしか Git の管理下に入らないようにしている。

こうすることで、新しく追加したファイルに秘匿すべき情報が含まれていた際に、誤ってコミットしてしまうミスを防げる。

### 2.2. Git のキャッシュ削除手順

- `.gitignore_global` を設定する前にコミットをしてしまった。
- 過去に追跡対象としてコミットしたファイルを `.gitignore` で追跡対象外にしたい。
- `.gitignore` を整理したので追跡対象の設定が問題ないか確認したい。

これらに該当する場合は Git のキャッシュ削除が必要になる。

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

### 2.3. PowerShell でスクリプトを実行する

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

### 2.4. Windows Terminal の GUID 復元手順

Windows Terminal の設定ファイルを上書きする際、環境によっては WSL を Windows Terminal で実行できなくなる場合がある。Ubuntu のバージョンに紐づけられた GUID が上書き前後で変わってしまったため。（※ 理解が正確でないかも）

この場合、下記の手順で上書き前の GUID を復元する。

1. `Ctrl + ,` で設定を開く。
2. `新しいプロファイルを追加します` を選択する。
3. `プロファイルを複製する` から `Ubuntu` など目的のプロファイルを選んで `複製` をクリックする。
4. 複製されたプロファイルの GUID を既存のプロファイルへ記述する。

## 3. Reference

<!-- omit in toc -->
### dotfiles 全般

- [ようこそdotfilesの世界へ - Qiita](https://qiita.com/yutakatay/items/c6c7584d9795799ee164)
- [【初心者版】必要最小限のdotfilesを運用する - Qiita](https://qiita.com/ganariya/items/d9adffc6535dfca6784b)
- [gitignoreのホワイトリストの書き方 - Qiita](https://qiita.com/sventouz/items/574bd67c7e43fff10546)
- [Windows と Mac で開発環境を揃える Tips 集 - Neo's World](https://neos21.net/tech/windows-mac-environment.html)

<!-- omit in toc -->
### WSL

- [WSL のインストール | Microsoft Docs](https://docs.microsoft.com/ja-jp/windows/wsl/install)
- [Windows Terminal + WSL 2 + Homebrew + Zsh - Qiita](https://qiita.com/okayurisotto/items/36f6f9df499a74e62bff)
- [windows10でVSCode+WSL2(Ubuntu)+Docker Desktopの開発環境を作る](https://zenn.dev/ivgtr/scraps/92e14f80683be9)
- [WSL その128 - Windowsの環境変数とLinuxの環境変数を相互に引き継ぎ可能に - kledgeb](https://kledgeb.blogspot.com/2017/12/wsl-128-windowslinux.html)
- [【WSL】パスのフォーマットを変換する wslpath コマンドの使い方 – ラボラジアン](https://laboradian.com/wslpath-command-for-wsl/)
- [Cygwinでgo入門を諦めてWSL環境を作ったがCygwinでも大丈夫だった - exits](https://yuelab82.hatenablog.com/entry/go_on_cygwin_and_wsl)

<!-- omit in toc -->
### Ubuntu

- [WSLのUbuntu環境を日本語化する：Tech TIPS - ＠IT](https://atmarkit.itmedia.co.jp/ait/articles/1806/28/news043.html)

<!-- omit in toc -->
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
- [zsh-syntax-highlighting をカスタマイズする](https://v2.aintek.xyz/posts/customize-zsh-syntax-highlighting)

<!-- omit in toc -->
### シェルスクリプト・シェル関数

- [シェルスクリプトを高級言語のような書き味に近づける Tips 集](https://sousaku-memo.net/php-system/1817)
- [使いやすいシェルスクリプトを書く | Taichi Nakashima](https://deeeet.com/writing/2014/05/18/shell-template/)
- [初心者向け、「上手い」シェルスクリプトの書き方メモ - Qiita](https://qiita.com/m-yamashita/items/889c116b92dc0bf4ea7d)
- [bashのヒアドキュメントを活用する - Qiita](https://qiita.com/take4s5i/items/e207cee4fb04385a9952)

<!-- omit in toc -->
### Git

- [最低限しておくといいgitconfigの設定 - Qiita](https://qiita.com/hayamofu/items/d8103e789196bcd8b489)
- [github/gitignore: A collection of useful .gitignore templates](https://github.com/github/gitignore)
- [gitignore に書くべきでないものは gitignore_global へ - Qiita](https://qiita.com/elzup/items/4c92a2abdab56db3fb4e)
- [gitignore_globalを作成する on OSX - Qiita](https://qiita.com/pira/items/dd67077c5b414c8eb59d)
- [.gitignoreに記載したのに反映されない件 - Qiita](https://qiita.com/fuwamaki/items/3ed021163e50beab7154)
- [gitのmerge --no-ff のススメ #Git - Qiita](https://qiita.com/nog/items/c79469afbf3e632f10a1)
- [git mergeのとき、デフォルトでno-ffになるようにする設定 - Technology Engineering](https://inaba.hatenablog.com/entry/2017/01/09/223810)
- [.gitconfigにinclude書くと捗る - 時計を壊せ](https://techblog.karupas.org/entry/2012/07/19/190313)
- [Git - Git の設定](https://git-scm.com/book/ja/v2/Git-%E3%81%AE%E3%82%AB%E3%82%B9%E3%82%BF%E3%83%9E%E3%82%A4%E3%82%BA-Git-%E3%81%AE%E8%A8%AD%E5%AE%9A)

<!-- omit in toc -->
### Homebrew

- [dotfiles管理にhomebrew-bundleを導入する - Qiita](https://qiita.com/so-heee/items/351f0ea4e79196754e52)
- [Brew Bundleの使い方](https://gist.github.com/yoshimana/43b9205ddedad0ad65f2dee00c6f4261)

<!-- omit in toc -->
### GCC

- [Windows10 でのC言語開発環境の作り方 - Qiita](https://qiita.com/fumigoro/items/a07f1e6f059ad4b2b3d2)
- [gccっていったいなんなんだ - Qiita](https://qiita.com/chihiro/items/1725f9dbb51942534641)

<!-- omit in toc -->
### Node.js

- [WSL 2 上で Node.js を設定する | Microsoft Docs](https://docs.microsoft.com/ja-jp/windows/dev-environment/javascript/nodejs-on-wsl)

<!-- omit in toc -->
### VS Code

- Markdown
    - [自己流の手順書フォーマットを公開してみた | DevelopersIO](https://dev.classmethod.jp/articles/non-97-operation-manual/)
    - [【小ネタ】Visual Studio Code で Markdown All in One 機能拡張のインデントを 4 スペースに変更する | DevelopersIO](https://dev.classmethod.jp/articles/201906-vscode-markdown-customize-indent-size-settings/)
    - [markdownlint のインデント調整 - public note](https://ts223.hatenablog.com/entry/vscode-mdl)
    - [「markdownlint」を使ってメンテナブルなMarkdownを目指してみる - 憂鬱な世界にネコパンチ！](https://nekopunch.hatenablog.com/entry/2018/10/16/230529)
    - [VSCode の markdownlint プラグインを特定ルールを無視する設定を行う | らくがきちょう v3](https://sig9.org/archives/4456)

<!-- omit in toc -->
### PowerShell

- [実行ポリシーについて - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.3)
- [Set-ExecutionPolicy (Microsoft.PowerShell.Security) - PowerShell | Microsoft Learn](https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-7.3)
- [PowerShellでこのシステムではスクリプトの実行が無効になっているため、ファイル hoge.ps1 を読み込むことができません。となったときの対応方法 - Qiita](https://qiita.com/ponsuke0531/items/4629626a3e84bcd9398f)
- [PowerShellの.bashrc的な設定ファイルこと$Profileについての紹介 - Qiita](https://qiita.com/smicle/items/0ca4e6ae14ea92000d18)
