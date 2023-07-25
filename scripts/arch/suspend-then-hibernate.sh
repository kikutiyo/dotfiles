#!/bin/bash
#=======================================
# suspend-then-hibernate.sh
# 遅延ハイバネーションの設定
#=======================================
set -eu

# ドロップインファイルの配置
sudo cp -Rv $(dirname $0)/etc/systemd/sleep.conf.d /etc/systemd
sudo cp -Rv $(dirname $0)/etc/systemd/system/systemd-suspend.service.d /etc/systemd/system
# systemdをリロード
sudo systemctl daemon-reload

