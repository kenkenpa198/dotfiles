#!/bin/bash

set -x
set -euo pipefail


###################################
# 関数定義
###################################
# 環境情報を表示
function show_environment {
    : --------------------------------
    : Display the current time
    : --------------------------------
    date

    : --------------------------------
    : Show System Information
    : --------------------------------
    uname -a

    : --------------------------------
    : Show OS Information
    : --------------------------------
    cat /etc/os-release

    : --------------------------------
    : Show current name name
    : --------------------------------
    whoami

    : --------------------------------
    : Show current shell
    : --------------------------------
    echo $SHELL

    : --------------------------------
    : Show Environment Variables
    : --------------------------------
    env

    : --------------------------------
    : Print Working Directory
    : --------------------------------
    pwd
}

# XDG Base Directory Specification
function export_xdg {
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_CACHE_HOME="$HOME/.cache"
    export XDG_DATA_HOME="$HOME/.local/share"
    export XDG_STATE_HOME="$HOME/.local/state"
}

# pacman の初期化
function init_pacman {
    # キーリングの初期化
    sudo pacman-key --init
    sudo pacman-key --populate
    sudo pacman -Syy archlinux-keyring

    # ミラーの最適化を自動実行
    sudo pacman -g
}

# セットアップに必須のパッケージが環境になければインストールする
function check_required_packages {
    # https://qiita.com/8ayac/items/b6b6f0a385d08659316b

    # sudo
    if ! (type "sudo" > /dev/null 2>&1); then
        : sudo is not installed
        case `cat /etc/issue` in
            Ubuntu*)
                : Ubuntu
                : Install sudo with apt
                sudo apt-get update && \
                sudo apt-get install -y sudo
            ;;
            Arch*)
                : Arch Linux
                : Install sudo with pacman
                sudo pacman -Syu sudo
            ;;
            *)
                : Unmatched
                echo "unmatched distributions"
        esac
    fi

    # git
    if ! (type "git" > /dev/null 2>&1); then
        : Git is not installed
        case `cat /etc/issue` in
            Ubuntu*)
                : Ubuntu
                : Install Git with apt
                sudo apt-get update && \
                sudo apt-get install -y git
            ;;
            Arch*)
                : Arch Linux
                : Install Git with pacman
                sudo pacman -Syu git
            ;;
            *)
                : Unmatched
                echo "unmatched distributions"
        esac
    fi
}

# git clone dotfiles
function clone_dotfiles {
    DOTFILES_HOME=${HOME}/dotfiles

    if [ ! -d "${DOTFILES_HOME}" ]; then
        git clone https://github.com/kenkenpa198/dotfiles.git "${DOTFILES_HOME}"
    else
        git -C "${DOTFILES_HOME}" pull origin main || true
    fi
}

# ディレクトリを作成
function make_dir {
    # XDG Base Directory Specification
    mkdir -p "$XDG_STATE_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME"
    mkdir -p "$XDG_STATE_HOME/zsh"

    # My directory
    mkdir -p ~/works/develop
}

# 初期ファイルをバックアップ
function backup_origin_files {
    cp ~/.bashrc ~/.bashrc.org
}

# 完了メッセージを表示
function print_finished {
    set +x
    echo "---------------------------------------"
    echo "Finished: $0"
    echo "---------------------------------------"
    echo "Default shell: $SHELL"
    echo "---------------------------------------"
    echo "Git config:"
    git config -l
    echo "---------------------------------------"
    echo "Please enter your [user.email] and [user.name] for Git."
    echo
    echo "    $ vim ~/.config/git/local"
    echo
    echo "---------------------------------------"
    echo "Next, Please reboot host."
}


###################################
# メイン処理
###################################
function main {
    # 環境情報を表示
    show_environment

    # XDG Base Directory Specification
    export_xdg

    # Arch の場合のみ pacman を初期化
    case `cat /etc/issue` in
        Arch*)
            : Arch Linux
            : Init pacman
            init_pacman
        ;;
    esac

    # セットアップに必須のパッケージが環境になければインストールする
    check_required_packages

    # git clone dotfiles
    clone_dotfiles

    # ディレクトリを作成
    make_dir

    # 初期ファイルをバックアップ
    backup_origin_files

    # アプリケーションのインストール
    bash "${HOME}/dotfiles/setup/linux/install-packages.sh"
    bash "${HOME}/dotfiles/setup/linux/install-sheldon.sh"
    bash "${HOME}/dotfiles/setup/linux/install-my-scripts.sh"

    # シンボリックリンクを作成
    bash "${HOME}/dotfiles/setup/linux/link.sh"

    # zsh をデフォルトシェルへ設定
    sudo chsh "$USER" -s "$(which zsh)"

    # 完了メッセージを出力
    print_finished
}

main
