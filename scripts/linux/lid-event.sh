#!/bin/bash

set -eu

SRC_DIR=$(cd $(dirname $0) && pwd)/etc-files/acpi

sudo cp ${SRC_DIR}/lid.sh /etc/acpi/lid.sh
sudo chmod +x /etc/acpi/lid.sh
sudo cp ${SRC_DIR}/events/lid /etc/acpi/events/lid

SRC_DIR=$(cd $(dirname $0) && pwd)/systemd/services
sudo cp ${SRC_DIR}/check-lid-{startup,resume}.service /etc/systemd/system

sudo systemctl daemon-reload
sudo systemctl enable \
    acpid.service \
    check-lid-startup.service \
    check-lid-resume.service
