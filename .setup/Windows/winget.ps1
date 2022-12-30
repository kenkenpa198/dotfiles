# ----------------
#    winget.ps1
# ----------------
# Windows 標準のパッケージマネージャーアプリ winget を使用して各アプリケーションをインストールする PowerShell スクリプト。
# アプリケーションに Microsoft Store 版が存在する場合、そちらを優先して記述している。
# Microsoft Store へログインしておき、管理者権限で実行する。


##### winget のソースを更新 #####
winget source update


##### Microsoft Store からインストール #####
# -s msstore                  : msstore をソースとして使用するオプション
# --accept-package-agreements : 使用許諾契約に同意するオプション

# 7-Zip
winget install --accept-package-agreements -s msstore XPDNKVCX4QD2DC

# Blender
winget install --accept-package-agreements -s msstore 9PP3C07GTVRH

# Brave
winget install --accept-package-agreements -s msstore XP8C9QZMS2PC1T

# Compress
winget install --accept-package-agreements -s msstore 9N1FHQZ38LHT

# CLIP STUDIO PAINT
winget install --accept-package-agreements -s msstore XPDP32QDDFL4PK

# DevToys
winget install --accept-package-agreements -s msstore 9PGCV4V3BK4W

# Discord
winget install --accept-package-agreements -s msstore XPDC2RH70K22MN

# EarTrumpet
winget install --accept-package-agreements -s msstore 9NBLGGH516XP

# HyperX NGENUITY
winget install --accept-package-agreements -s msstore 9P1TBXR6QDCX

# iCloud
winget install --accept-package-agreements -s msstore 9PKTQ5699M62

# iTunes
winget install --accept-package-agreements -s msstore 9PB2MZ1ZMB1S

# LINE
winget install --accept-package-agreements -s msstore 9WZDNCRFJ2G6

# OBS Studio
winget install --accept-package-agreements -s msstore XPFFH613W8V6LV

# PowerToys
winget install --accept-package-agreements -s msstore XP89DCGQ3K6VLD

# Python 3.10
winget install --accept-package-agreements -s msstore 9PJPW5LDXLZ5

# QuickLook
winget install --accept-package-agreements -s msstore 9NV4BS3L1H4S

# Twinkle Tray
winget install --accept-package-agreements -s msstore 9PLJWWSV01LK

# Visual Studio Code
winget install --accept-package-agreements -s msstore XP9KHM4BK9FZ7Q


##### winget からインストール #####
# -e   : クエリで正確な文字列を使用するオプション
# --id : インストールをアプリケーションの ID に限定するオプション

# AutoHotKey
winget install --accept-package-agreements -e --id Lexikos.AutoHotkey

# Avidemux
winget install --accept-package-agreements -e --id Avidemux.Avidemux

# Azure Data Studio
winget install --accept-package-agreements -e --id Microsoft.AzureDataStudio

# Caesium Image Compressor
winget install --accept-package-agreements -e --id SaeraSoft.CaesiumImageCompressor

# Docker Desktop
winget install --accept-package-agreements -e --id Docker.DockerDesktop

# Elgato 4K Capture Utility
winget install --accept-package-agreements -e --id Elgato.4KCaptureUtility

# Git for Windows
winget install --accept-package-agreements -e --id Git.Git

# Google Chrome
winget install --accept-package-agreements -e --id Google.Chrome

# Obsidian
winget install --accept-package-agreements -e --id Obsidian.Obsidian

# Steam
winget install --accept-package-agreements -e --id Valve.Steam

# VNC Viewer
winget install --accept-package-agreements -e --id RealVNC.VNCViewer

# WinMerge
winget install --accept-package-agreements -e --id WinMerge.WinMerge

# WinSCP
winget install --accept-package-agreements -e --id WinSCP.WinSCP
