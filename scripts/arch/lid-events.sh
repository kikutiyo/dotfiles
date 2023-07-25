#!/bin/bash
#=======================================
# lid-events.sh
# リッド開閉時処理の設定
#=======================================
set -eu

# acpidのインストール
paru -S --needed --noconfirm --sudoloop \
    acpid
# イベント処理スクリプトをインストール
sudo cp -Rv $(dirname $0)/etc/acpi/* /etc/acpi
sudo chmod +x /etc/acpi/lid.sh
sudo cp -v $(dirname $0)/etc/systemd/system/check-lid-{resume,startup}.service /etc/systemd/system
# サービスを有効化
sudo systemctl daemon-reload
sudo systemctl enable --now acpid.service
sudo systemctl enable check-lid-{resume,startup}.service
