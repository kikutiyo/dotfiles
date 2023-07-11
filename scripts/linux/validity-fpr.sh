#!/bin/bash

set -eu

sudo pacman -Q fprintd && sudo pacman -R --noconfirm fprintd
paru -S --needed --noconfirm \
    open-fprintd \
    python-validity

OVERRIDE_DIR=/etc/systemd/system/open-fprintd-resume.service.d
test -d ${OVERRIDE_DIR} || sudo mkdir -p ${OVERRIDE_DIR}
sudo cp -R $(cd $(dirname $0) && pwd)/systemd/overrides/open-fprintd-resume.service ${OVERRIDE_DIR}/override.conf

sudo systemctl enable \
    python3-validity.service \
    open-fprintd.service \
    open-fprintd-suspend.service \
    open-fprintd-resume.service
