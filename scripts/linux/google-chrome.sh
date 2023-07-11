#!/bin/bash

set -eu

paru -S --needed --noconfirm \
    google-chrome \
    intel-media-driver \
    libva-utils \
    intel-gpu-tools
ln -s $(cd .. && pwd)/xdg_config/chrome-flags.conf ${HOME}/.config/chrome-flags.conf
