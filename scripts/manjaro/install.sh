#!/bin/bash

set -eu

# アプリケーションをインストール
paru -S --needed --noconfirm --batchinstall \
    fcitx5-im \
    mozc-ut \
    fcitx5-mozc-ut \
    1password \
    1password-cli \
    google-chrome \
    intel-media-driver \
    libva-utils \
    intel-gpu-tools \
    rclone \
    solaar \
    tlp \
    tlpui \
    smartmontools \
    $(sudo pacman -Qq linux | sed -E 's/$/-headers/') \
    vmware-workstation \
    visual-studio-code-bin \
    cloudflare-warp-bin \
    cnrdrvcups-lb-bin \
    libjbig-shared \
    wl-clipboard \
    noto-fonts-cjk \
    ttf-hackgen

# 自動起動ファイルを作成
sed -E 's/(^Exec=.+\/1password)/\1 --silent/' \
    /usr/share/applications/1password.desktop > ~/.config/autostart/1password.desktop
sed -E 's/^(Exec=.*solaar)/\1 --window=hide/' \
    /usr/share/applications/solaar.desktop > ~/.config/autostart/solaar.desktop
# サービス有効化
sudo systemctl enable --now \
    vmware-networks.service \
    vmware-usbarbitrator.service \
    warp-svc
# カーネルモジュール追加
sudo modprobe -a vmw_vmci vmmon
