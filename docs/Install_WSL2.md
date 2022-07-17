<!-- omit in toc -->
# 環境構築メモ - WSL2

WSL2 環境の構築メモ。  
完全に自分用のメモであり、旧い情報や誤りがある可能性があるため、参考にする際は自己責任でお願いします。

<!-- omit in toc -->
## 目次

- [1. 必要環境・環境構築方法](#1-必要環境環境構築方法)
- [2. オプション](#2-オプション)
    - [2.1. Windows Terminal の設定](#21-windows-terminal-の設定)
    - [2.2. WSLENV 環境変数の設定](#22-wslenv-環境変数の設定)

## 1. 必要環境・環境構築方法

[kenkenpa198/MSSQL_with_Docker](https://github.com/kenkenpa198/MSSQL_with_Docker) の `環境構築メモ.md` を参照。  
Docker・Docker Compose のインストール方法もそちらに掲載。

## 2. オプション

以降の工程は必要がある場合に行う。

### 2.1. Windows Terminal の設定

Windows Terminal は CMD や PowerShell などを使える Microsoft 製の統合型ターミナル。  
WSL2 をインストールすると自動で Linux 側のターミナルも使えるように設定されるため、確認のみ行う。

1. WSL2 のインストールが終わったらスタートメニューなどから Windows Terminal を立ち上げる。
    1. インストールされていない場合、Microsoft Store から入手する。
2. 新規タブを開くプルダウンメニューに Ubuntu があることを確認する。
3. 開いてみてコマンドをいろいろ送信し、正しく操作できることを確認する。

### 2.2. WSLENV 環境変数の設定

WSLENV という環境変数を設定すると、Windows 環境の環境変数を WSL2 側へ渡すことができる。  
WSL2 ではアプリケーションのパス等は自動で渡されるようなので、必要な場合にのみ設定する。

例）Win 環境の `USERPROFILE` と `USERNAME` を渡したい場合

1. Windows のスタートメニューへ `env` と入力し、「システム環境変数の編集」を立ち上げる。
2. `環境変数 > ~~~ のユーザー環境変数(U)` へ下記を追加する。
    1. 変数名: `WSLENV`
    2. 変数値: `USERPROFILE/pu:USERNAME/pu` ※
3. WSL2 環境へ Win 環境の環境変数がきちんと渡されているか確認する。

    ```shell
    > echo $USERPROFILE
    /mnt/c/Users/{Win_home_dir}
    ```

※ 変数の値は `変数名1/オプション:変数名2/オプション:...` というフォーマットで記述。

- p オプション : WindowsのパスとLinuxのパスを変換して環境変数を引き継ぐ
- u オプション : Windows環境からLinux環境を起動した時にのみ、環境変数を引き継ぐ
