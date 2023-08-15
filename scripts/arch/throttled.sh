#!/bin/bash

set -eu

# インストール
paru -S --needed --noconfirm --sudoloop throttled
# サービスを有効化
sudo systemctl enable --now throttled.service
