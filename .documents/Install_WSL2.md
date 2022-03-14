<!-- omit in toc -->
# 環境構築メモ - WSL2

WSL2 環境の構築メモ。  
以下の環境を構築して連携させるのがゴール。

- Windows 環境
  - WSL2（Ubuntu）の構築
  - 環境変数の設定
  - Windows Terminal の設定
- WSL2（Ubuntu）環境
  - zsh 等の基本アプリケーションのインストール
  - Docker のインストール

## 1. 必要な環境

- OS: Windows 10 バージョン 2004 以降 (ビルド 19041 以降) または Windows 11
  - `wsl` コマンド、`winget` コマンドの実行に必要なため。
- メモリ: 2GB 以上
  - SQL Server の Docker Image が 2GB 以上必要ぽかった。  
  WSL2 のメモリ制限を 1GB に設定していたらコンテナが起動できず、ログを確認するとメモリ不足で落ちてたっぽかった。制限する場合は注意。
- 空き容量: 要確認

## 2. WSL2 のインストール

WSL2 とは仮想の Linux 環境を Windows 10 上に構築するすごいやつ。  
本手順では Ubuntu をインストールする。

少し前までは色々と設定を行わないといけなかったんだけど、  
最近はコマンドほぼ一発でインストールできるようになった（すごい）。

1. PowerShell を管理者権限で起動する。
2. 下記のコマンドを入力して送信する。

    ```shell
    wsl --install -d Ubuntu
    ```

3. インストールが開始するので、処理が完了するまで待つ。
4. 処理が完了したら、スタートメニューで「Ubuntu」と入力する。
5. スタートメニューに Ubuntu が表示されていれば一旦インストール完了。次の工程へ。

## 3. Ubuntu 環境の初期設定

インストールした Ubuntu を立ち上げて、初期設定を行っていく。

1. スタートメニューから Ubuntu をクリックして起動する。
   1. ここで下記のエラーが出力される可能性がある。

      ```shell
      Installing, this may take a few minutes...
      WslRegisterDistribution failed with error: 0x800701bc
      Error: 0x800701bc WSL 2 ???????????? ??????????????????????? https://aka.ms/wsl2kernel ?????????
      ```

   2. このエラーが出力された場合、エラー内容に記載されている [https://aka.ms/wsl2kernel](https://aka.ms/wsl2kernel) から「Linux カーネル更新プログラム パッケージ」をダウンロードする。
   3. Ubuntu のウィンドウを閉じる。
   4. ダウンロードしたパッケージをインストールする。
   5. インストール完了後、Ubuntu を再度立ち上げて次の工程のメッセージが出力されるか確認する。
2. `Installing, this may take a few minutes...` と表示されるので少し待つ。
3. しばらく待つと「UNIX username」と「password」の入力を求められるので設定する。  
※ユーザー設定途中で Ubuntu を閉じてしまうとかなり面倒くさいことになるので気を付ける！

初期設定は以上。  
Ubuntu 本体のアプリからだとコピペ等ができないので、初期構築が済んだ後は Windows Terminal で設定を行っていく。

## 4. Windows Terminal と dotfiles で Ubuntu 環境を整える

Windows Terminal は CMD とか PowerShell とかを使える統合型のターミナル。  
WSL2 をインストールすると、自動で Linux 側のターミナルも使えるように設定される（ありがたい）。

1. WSL2 のインストールが終わったらスタートメニューなどから Windows Terminal を立ち上げる。
2. 新規タブを開くプルダウンメニューに Ubuntu があることを確認する。
3. 開いてみてコマンドをいろいろ送信し、正しく操作できることを確認する。
4. Ubuntu 環境を最新版にアップデートするため、下記のコマンドを入力して送信する。

    ```shell
    > sudo apt update && sudo apt upgrade -y
    ```

5. [README.md](README.md) の冒頭にあるコマンドを順に送信し、dotfiles のクローンから必要アプリのインストールを行っていく。
6. 完了したらエイリアスが動くかどうかなどいろいろ確認する。

とりあえずはここまでで WSL2 の構築は完了！  
必要あれば次項の工程も行っていく。

## 5. WSLENV 環境変数の設定

WSLENV という環境変数を設定する。  
この環境変数を設定すると、Windows 環境の環境変数を WSL2 側へ渡すことができる。

現在は丸ごと移植するような指定方法になっていて処理が重い状態になっているので改善の余地あり。

1. Windows のスタートメニューへ `env` と入力し、「システム環境変数の編集」を立ち上げる。
2. `環境変数 > XXX のユーザー環境変数(U)` へ下記を追加する。
   1. 変数名: `WSLENV`
   2. 変数値: `Path/pu:USERPROFILE/pu`
3. WSL2 環境へ Win 環境の環境変数がきちんと渡されているか確認する。

    ```shell
    > echo $USERPROFILE
    /mnt/c/Users/{HOME DIR}
    ```

ここまでで設定は完了。  
ちなみに、本来であれば工程 2 の後に下記を WSL2 側の環境変数へ記述する。

```shell
export PATH="$PATH:$Path"
```

こうすることで、WSLENV で渡すように設定した Win 側の環境変数を WSL2 側で受け取ることができるようになる。  
当手順では dotfiles の .zshrc で設定済みなので作業は不要。

## 6. Docker・Docker Compose のインストール・設定

仮想環境を構築したり共有したり色々できるすごいやつ。  
CLI 版のみか、Win 環境に Docker Desktop もインストールされているかでインストール方法が変わるぽいので注意。

### 6.1. Docker のインストール（Docker Desktop なしの場合）

[setup_docker.sh](Documents/Install_WSL2.md) に書いているコマンドを順に送信してインストールする。  
スクリプトとして実行すると「3. Docker の公式 GPG キーを追加」で止まるぽいので手動でやった方がいいかも。

### 6.2. Docker のインストール（Docker Desktop ありの場合）

1. Docker Desktop の以下の設定をオンにする。

    ```text
    Docker Desktop > Settings > Resources > WSL INTEGRATION > Enable integration with additional distros: > Ubuntu
    ```

2. 再起動して `docker -v` を送信し、WSL2 環境で Docker が使えるか確認する。

    ```shell
    > docker -v
    Docker version 20.10.6, build 370c289
    ```

### 6.3. Docker を sudo 無しでも実行できるようにする

1. 下記を実行する。

    ```shell
    > getent group docker
    > sudo gpasswd -a kenkenpa198 docker
    ```

2. Ubuntu を再起動する。
3. sudo 無しで実行してみる。

    ```shell
    > docker run hello-world
    ```

### 6.4. Docker Compose のインストール

1. curl でインストールする

    ```shell
    > sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    > sudo chmod +x /usr/local/bin/docker-compose
    > docker-compose -v
    ```

### 6.5. コンテナの稼働テスト

`docker run hello-world` や [kenkenpa198/MSSQL_with_Docker](https://github.com/kenkenpa198/MSSQL_with_Docker) でコンテナの稼働や接続を確認する。

Docker Desktop から設定を行った場合は、WSL2 側で起動した際に Docker Desktop 側にも起動したコンテナなどが表示されているかまで確認する。

## 7. 参考サイト様

### 7.1. WSL2

- [WSL のインストール | Microsoft Docs](https://docs.microsoft.com/ja-jp/windows/wsl/install)
- [windows10でVSCode+WSL2(Ubuntu)+Docker Desktopの開発環境を作る](https://zenn.dev/ivgtr/scraps/92e14f80683be9)
- [Windows Terminal + WSL 2 + Homebrew + Zsh - Qiita](https://qiita.com/okayurisotto/items/36f6f9df499a74e62bff)
- [WSL その128 - Windowsの環境変数とLinuxの環境変数を相互に引き継ぎ可能に - kledgeb](https://kledgeb.blogspot.com/2017/12/wsl-128-windowslinux.html)
- [【WSL】パスのフォーマットを変換する wslpath コマンドの使い方 – ラボラジアン](https://laboradian.com/wslpath-command-for-wsl/)
- [Cygwinでgo入門を諦めてWSL環境を作ったがCygwinでも大丈夫だった - exits](https://yuelab82.hatenablog.com/entry/go_on_cygwin_and_wsl)

### 7.2. Docker

- [Install Docker Engine on Ubuntu | Docker Documentation](https://docs.docker.com/engine/install/ubuntu/)
- [ubuntu20.04にDockerとdocker-composeをインストールする](https://zenn.dev/k_neko3/articles/76340d2db1f43d)
