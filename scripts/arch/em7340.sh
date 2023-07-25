#!/bin/bash
#=======================================
# validity-fpr.sh
# EM7340 LTEアダプタの設定
#=======================================
set -eu

# FCCアンロックスクリプトの設定
sudo ln -sf /usr/share/ModemManager/fcc-unlock.available.d/1199 /etc/ModemManager/fcc-unlock.d/1199:907b
# サービスの有効化
sudo systemctl enable --now ModemManager.service
