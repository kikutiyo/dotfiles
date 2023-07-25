#!/bin/bash

set -eu

# GNOMEメタパッケージのインストール
if [[ "${XDG_CURRENT_DESKTOP}" != "GNOME" ]]; then
    paru -S --needed --noconfirm --sudoloop gnome
fi
# GDMと追加アプリ・フォントをインストール
paru -S --needed --noconfirm --sudoloop \
    gdm \
    gnome-tweaks \
    gnome-terminal \
    noto-fonts \
    noto-fonts-cjk \
    noto-fonts-emoji \
    noto-fonts-extra \
    ttf-hackgen 
# 分数スケーリング対応版mutter,gccに置き換え
paru -S --needed --sudoloop --batchinstall \
    mutter-x11-scaling \
    gnome-control-center-x11-scaling
# GDMサービスを有効化
sudo systemctl enable gdm.service
