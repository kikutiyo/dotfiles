#!/bin/bash

set -eu

# インストール
paru -S --needed --noconfirm --sudoloop --batchinstall \
    tlp \
    tlpui \
    smartmontools
# サービスを有効化
sudo systemctl enable --now tlp.service
