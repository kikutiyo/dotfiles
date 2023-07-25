#!/bin/bash
#=======================================
# validity-fpr.sh
# Validity Fingerprint Readerの設定
#=======================================
set -eu

# python-validityをインストール
paru -S --needed --noconfirm --sudoloop \
    python-validity 
# 復帰時処理をオーバーライド
sudo cp -Rv $(dirname $0)/etc/systemd/system/open-fprintd-resume.service.d /etc/systemd/system
# サービスの有効化
sudo systemctl daemon-reload
sudo systemctl enable --now \
    python3-validity.service \
    open-fprintd.service 
sudo systemctl enable \
    open-fprintd-suspend.service \
    open-fprintd-resume.service
# PAMで指紋認証を有効化
sudo cp -Rv $(dirname $0)/etc/pam.d/* /etc/pam.d
