#!/bin/bash

set -eu

# インストール
paru -S --needed --noconfirm --sudoloop --batchinstall \
    1password \
    1password-cli
# 自動起動ファイルを作成
if [[ ! -e ${HOME}/.config/autostart ]]; then
    mkdir -p ${HOME}/.config/autostart
fi
sed -E 's/(^Exec=.+\/1password)/\1 --silent/' \
    /usr/share/applications/1password.desktop > ${HOME}/.config/autostart/1password.desktop
