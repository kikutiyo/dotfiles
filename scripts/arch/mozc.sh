#!/bin/nash

set -eu

# インストール
paru -S --needed --noconfirm --suduloop --batchinstall \
    fcitx5-im \
    mozc-ut \
    fcitx5-mozc-ut
# 環境変数ファイルを配置
if [[ ! -e ${HOME}/.config/environment.d ]]; then
    mkdir -p ${HOME}/.config/environment.d
fi
cp -v $(dirname $0)/.config/environment.d/im.conf ${HOME}/.config/environment.d
