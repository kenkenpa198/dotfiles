<!-- omit in toc -->
# dotfiles

```shell
curl -fsSL https://raw.githubusercontent.com/kenkenpa198/dotfiles/main/setup/ubuntu/setup.sh | bash
```

<!-- omit in toc -->
## TOC

- [1. Setup](#1-setup)
    - [1.1. for Ubuntu](#11-for-ubuntu)
    - [1.2. for Ubuntu on WSL \& Windows](#12-for-ubuntu-on-wsl--windows)
    - [1.3. for MacOS](#13-for-macos)
- [2. Tips](#2-tips)
    - [2.1. ホワイトリスト形式の .gitignore](#21-ホワイトリスト形式の-gitignore)
    - [2.2. Git のキャッシュ削除手順](#22-git-のキャッシュ削除手順)
    - [2.3. PowerShell でスクリプトを実行する](#23-powershell-でスクリプトを実行する)
    - [2.4. Windows Terminal の GUID 復元手順](#24-windows-terminal-の-guid-復元手順)

## 1. Setup

### 1.1. for Ubuntu

ホームディレクトリ上で README 冒頭のコマンドを実行する。

### 1.2. for Ubuntu on WSL & Windows

1. PowerShell を管理者権限で起動し、次のコマンドを実行して WSL をセットアップする。

    ```powershell
    wsl --install
    ```

    参考: [WSL のインストール | Microsoft Learn](https://learn.microsoft.com/ja-jp/windows/wsl/install)

2. ホームディレクトリ上で README 冒頭のコマンドを実行する。
3. 管理者権限の PowerShell で [setup/windows](setup/windows) 配下のスクリプトを順次実行する。

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
    # そのプロセスでのみ有効にする
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
