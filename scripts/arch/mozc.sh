#!/bin/nash

set -eu

# インストール
paru -S --needed --noconfirm --suduloop --batchinstall \
    fcitx5-im \
    mozc-ut \
    fcitx5-mozc-ut
