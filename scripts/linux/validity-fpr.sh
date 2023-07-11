#!/bin/bash

set -eu

sudo pacman -R --noconfirm fprintd
paru -S --needed --noconfirm \
    open-fprintd \
    python-validity

OVERRIDE_DIR=/etc/systemd/system/open-fprintd-resume.service.d
test -d ${OVERRIDE_DIR} || sudo mkdir -p ${OVERRIDE_DIR}
sudo cp -R $(cd $(dirname $0) && pwd)/systemd-overrides/open-fprintd-resume.conf ${OVERRIDE_DIR}/override.conf

sudo systemctl enable \
    python3-validity.service \
    open-fprintd.service \
    open-fprintf-suspend.service \
    open-fprintf-resume.service
