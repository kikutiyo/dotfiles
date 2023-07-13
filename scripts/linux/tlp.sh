#!/bin/bash

set -eu

paru -S --needed --noconfirm \
    tlp \
    tlpui \
    smartmontools
sudo systemctl enable tlp.service
