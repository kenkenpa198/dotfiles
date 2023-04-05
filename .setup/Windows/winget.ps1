# ----------------
#    winget.ps1
# ----------------
# Windows 標準のパッケージマネージャーアプリ winget を使用して各アプリケーションをインストールする PowerShell スクリプト。

# Microsoft Store へログインしておき、管理者権限で実行する。
# ダウンロードのソースが winget と Microsoft Store 両方に存在する場合は公式推奨の方に合わせている。

# スクリプトの実行には実行ポリシーの変更が必要。
# 参考 : https://qiita.com/ponsuke0531/items/4629626a3e84bcd9398f

##### winget のソースを更新 #####
winget source update


##### winget からインストール #####
# -e   : クエリで正確な文字列を使用するオプション
# --id : インストールをアプリケーションの ID に限定するオプション

# 7-Zip
winget install -e --id 7zip.7zip

# AutoHotKey
winget install -e --id Lexikos.AutoHotkey

# Avidemux
winget install -e --id Avidemux.Avidemux

# Azure Data Studio
winget install -e --id Microsoft.AzureDataStudio

# Bitwarden
winget install -e --id Bitwarden.Bitwarden

# Blender
winget install -e --id BlenderFoundation.Blender

# Brave
winget install -e --id Brave.Brave

# Caesium Image Compressor
winget install -e --id SaeraSoft.CaesiumImageCompressor

# Discord
winget install -e --id Discord.Discord

# Docker Desktop
winget install -e --id Docker.DockerDesktop

# Elgato 4K Capture Utility
winget install -e --id Elgato.4KCaptureUtility

# Git for Windows
winget install -e --id Git.Git

# Google Chrome
winget install -e --id Google.Chrome

# Google Drive
winget install -e --id Google.Drive

# LINE
winget install -e --id LINE.LINE

# Logi Options+
winget install -e --id Logitech.OptionsPlus

# OBS Studio
winget install -e --id OBSProject.OBSStudio

# Obsidian
winget install -e --id Obsidian.Obsidian

# Screen To Gif
winget install -e --id NickeManarin.ScreenToGif

# Steam
winget install -e --id Valve.Steam

# VNC Viewer
winget install -e --id RealVNC.VNCViewer

# WinMerge
winget install -e --id WinMerge.WinMerge

# WinSCP
winget install -e --id WinSCP.WinSCP

# Visual Studio Code
winget install -e --id Microsoft.VisualStudioCode


##### Microsoft Store からインストール #####
# --accept-package-agreements : 使用許諾契約に同意するオプション
# -s msstore                  : msstore をソースとして使用するオプション

# CLIP STUDIO PAINT
winget install --accept-package-agreements -s msstore XPDP32QDDFL4PK

# DevToys
winget install --accept-package-agreements -s msstore 9PGCV4V3BK4W

# EarTrumpet
winget install --accept-package-agreements -s msstore 9NBLGGH516XP

# HyperX NGENUITY
winget install --accept-package-agreements -s msstore 9P1TBXR6QDCX

# iTunes
winget install --accept-package-agreements -s msstore 9PB2MZ1ZMB1S

# PowerToys
winget install --accept-package-agreements -s msstore XP89DCGQ3K6VLD

# Python 3.10
winget install --accept-package-agreements -s msstore 9PJPW5LDXLZ5

# QuickLook
winget install --accept-package-agreements -s msstore 9NV4BS3L1H4S

# Twinkle Tray
winget install --accept-package-agreements -s msstore 9PLJWWSV01LK
