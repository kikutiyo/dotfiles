#!/bin/bash

set -eu

get_usb_device_id() {
    lsusb -d $1: | sed -E 's/^.+ID (.{4}:.{4}) .+$/\1/'
}

BASE_DIR=$(cd $(dirname $0) && pwd)

# Synaptics Validity指紋認証センサーがある場合はpython-validityをインストール
if [[ "$(get_usb_device_id 06cb)" =~ 06cb:00(9a) ]]; then
    echo "=====> Setup python-validity"
    pacman -Qq fprintd && sudo pacman -R --noconfirm fprintd
    paru -S --needed --noconfirm \
        open-fprintd \
        python-validity
    sudo cp -Rv ${BASE_DIR}/etc/systemd/system/open-fprintd-resume.service.d /etc/systemd/system
    sudo systemctl enable --now \
        python3-validity.service \
        open-fprintd.service 
    sudo systemctl enable \
        open-fprintd-suspend.service \
        open-fprintd-resume.service
fi

# LTEモジュールがある場合はModemManagerのFCCアンロックスクリプトを設定
if [[ ! -z "$(get_usb_device_id 1199)" ]]; then
    echo "=====> Enable Sierra Wireless LTE module"
    sudo ln -sf /usr/share/ModemManager/fcc-unlock.available.d/1199 /etc/ModemManager/fcc-unlock.d/${LTE_DEV_ID}
fi

# ノートの場合は遅延ハイバネーションとリッドイベント処理を設定
CHASSIS_TYPE=$(sudo dmidecode --type chassis | grep -i 'Type' | sed -E 's/^.*: //')
if [[ "${CHASSIS_TYPE}" =~ Notebook ]]; then
    # 遅延ハイバネーションの設定
    echo "=====> Set suspend-then-hibernate as suspend behaviour"
    sudo cp -Rv ${BASE_DIR}/etc/systemd/system/{sleep.conf.d,systemd-suspend.service.d} /etc/systemd/system
    # リッドイベント処理のインストール
    echo "=====> Setup scripts for lid events"
    sudo cp -Rv ${BASE_DIR}/etc/acpi /etc
    sudo cp -v ${BASE_DIR}/etc/systemd/system/check-lid-*.service /etc/systemd/system
    sudo chmod +x /etc/acpi/lid.sh
    sudo systemctl daemon-reload
    sudo systemctl enable \
        acpid.service \
        check-lid-{startup,resume}.service
fi

# マシンタイプ20L6(ThinkPad T480)の場合はthrottledをインストール
PRODUCT_NAME=$(sudo dmidecode --type system | grep -i 'Product Name:' | sed -E 's/^.*: //')
if [[ "${PRODUCT_NAME}" =~ 20L6.+ ]]; then
    echo "=====> Setup throttled"
    paru -S --needed --noconfirm throttled
    sudo systemctl enable --now throttled.service
fi
