# WSL2 Ubuntu 環境へ Docker をインストールするスクリプト。
# 参考:
# https://docs.docker.com/engine/install/ubuntu/
# https://zenn.dev/k_neko3/articles/76340d2db1f43d
# https://zenn.dev/kathmandu/articles/4a86c3d75b93c3

# スクリプトとして実行すると「3. Docker の公式 GPG キーを追加」で止まるぽいのでそこから手動で対応。

echo '==================================='
echo '   Install docker to WSL2 Ubuntu'
echo '==================================='

echo '\n1. Linux 環境の更新'
read Wait
sudo apt update && sudo apt upgrade -y

echo '\n2. 必要パッケージをインストール'
read Wait
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y

echo '\n3. Docker の公式 GPG キーを追加'
read Wait
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo '\n4. リポジトリの設定'
read Wait
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo '\n5. Docker のインストール'
read Wait
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
docker version

echo '\n6. sudo 無しでも実行できるようにする'
read Wait
getent group docker
sudo gpasswd -a $USER docker

echo '\n7. 起動テスト'
read Wait
docker run hello-world

echo '\n8. 「Hello from Docker!」と表示されたら完了! 起動できなかった場合はコメントを確認してね'
read Wait


##### Docker が起動していない場合 #####
# 1. 下記のように言われていたらDockerが起動していないので……
# -----
# > sudo docker run hello-world
# [sudo] password for <<username>>:
# docker: Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?.
# -----

# 2. Docker が起動中であるか確認し、起動していなければ起動する。
# -----
# > sudo service docker status                # 確認
# * Docker is not running

# > sudo service docker start                 # 起動する
# * Starting Docker: docker        [ OK ]

# > sudo service docker status                # こう表示されれば OK
# * Docker is running

# > sudo service docker stop                  # 止める場合はコレ
# * Stopping Docker: docker        [ OK ]
# -----

# 3. もう一度 sudo docker run hello-world を実行する。

# 4. 下記のように表示されれば OK 。
# -----
# Unable to find image 'hello-world:latest' locally
# latest: Pulling from library/hello-world
# 2db29710123e: Pull complete
# Digest: sha256:975f4b14f326b05db86e16de00144f9c12257553bba9484fed41f9b6f2257800
# Status: Downloaded newer image for hello-world:latest

# ...

# Hello from Docker!
# This message shows that your installation appears to be working correctly.
# -----


##### Docker Desktop をインストール済みである場合 #####

# 1. こういうメッセージが表示されたら
# -----
# USERNAME@PC-NAME:~$ docker -v

# The command 'docker' could not be found in this WSL 2 distro.
# We recommend to activate the WSL integration in Docker Desktop settings.

# See https://docs.docker.com/docker-for-windows/wsl/ for details.
# -----

# 2. Docker Desktop の以下の設定をオンにする。
# Docker Desktop > Settings > Resources > WSL INTEGRATION > Enable integration with additional distros: > Ubuntu

# 3. もう一回実行すると動く
# ---
# USERNAME@PC-NAME:~$ docker -v
# Docker version 20.10.6, build 370c289
# ---