#!/bin/nash

set -eu

# インストール
paru -S --needed --noconfirm --sodoloop --batchinstall \
    tlp \
    tlpui \
    smartmontools
# サービスを有効化
sudo systemctl enable --now tlp.service
