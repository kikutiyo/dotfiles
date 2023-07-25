#!/bin/bash

set -eu

# インストール
paru -S --needed --noconfirm --sudoloop --batchinstall \
    cups \
    cnrdrvcups-lb-bin \
    libjbig-shared
# サービスを有効化
sudo systemctl enable --now cups.service
