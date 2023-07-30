#!/bin/nash

set -eu

# インストール
paru -S --needed --noconfirm --sudoloop --batchinstall \
    google-chrome \
    intel-media-driver \
    libva-utils \
    intel-gpu-tools
# フラグ設定ファイルを配置
cp -v $(dirname $0)/.config/chrome-flags.conf ${HOME}/.config
