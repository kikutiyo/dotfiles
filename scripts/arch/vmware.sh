#!/bin/bash

set -eu

# インストール
paru -S --needed --noconfirm --sudoloop vmware-workstation
# カーネルモジュール追加
sudo modprobe -a vmw_vmci vmmon
# サービス有効化
sudo systemctl enable \
    vmware-networks.service \
    vmware-usbarbitrator.service
sudo systemctl enable --now \
    vmware-networks.path \
    vmware-usbarbitrator.path
