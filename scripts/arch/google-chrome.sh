#!/bin/nash

set -eu

# インストール
paru -S --needed --noconfirm --sudoloop --batchinstall \
    google-chrome \
    intel-media-driver \
    libva-utils \
    intel-gpu-tools
