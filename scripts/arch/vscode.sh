#!/bin/bash

set -eu

# インストール
paru -S --needed --noconfirm --sudoloop visual-studio-code-bin
# ディレクトリの標準ハンドラをNautilusに戻す
gio mime inode/directory org.gnome.Nautilus.desktop
