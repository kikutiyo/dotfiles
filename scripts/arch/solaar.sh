#!/bin/bash

set -eu

# インストール
paru -S --needed --noconfirm --suduloop \
    solaar \
    libayatana-appindicator
# 自動起動ファイルを作成
sed -E 's/^(Exec=.*solaar)/\1 -w hide/' \
    /usr/share/applications/solaar.desktop > ${HOME}/.config/autostart/solaar.desktop
