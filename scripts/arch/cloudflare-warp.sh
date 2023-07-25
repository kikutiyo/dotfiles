#!/bin/bash

set -eu

# インストール
paru -S --needed --noconfirm --sudoloop cloudflare-warp-bin
# サービスを有効化
sudo systemctl enable --now warp-svc.service

