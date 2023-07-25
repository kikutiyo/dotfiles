#!/bin/bash

set -eu

# インストール
paru -S --needed --noconfirm --suduloop --batchinstall \
    1password \
    1password-cli
# 自動起動ファイルを作成
sed -E 's/(^Exec=.+\/1password)/\1 --silent/' \
    /usr/share/applications/1password.desktop > ${HOME}/.config/autostart/1password.desktop
