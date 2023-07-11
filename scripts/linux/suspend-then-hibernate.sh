#!/bin/bash

set -eu

SRC_DIR=$(cd $(dirname $0) && pwd)/systemd/overrides

sudo mkdir -p /etc/systemd/sleep.conf.d
sudo cp ${SRC_DIR}/sleep.conf /etc/systemd/sleep.conf.d/override.conf
sudo mkdir -p /etc/systemd/system/systemd-suspend.service.d
sudo cp ${SRC_DIR}/systemd-suspend.service /etc/systemd/system/systemd-suspend.service.d/override.conf

sudo systemctl daemon-reload
