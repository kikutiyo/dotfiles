#!/bin/bash

set -eu

# 1Passwordをインストール
paru -S --needed --noconfirm \
    1password \
    1password-cli
# 自動起動ファイルを作成
if [[ -e /usr/share/applications/1password.desktop ]]; then
    sed -E 's/(^Exec=.+\/1password)/\1 --silent/' \
        /usr/share/applications/1password.desktop > ~/.config/autostart/1password.desktop
fi
