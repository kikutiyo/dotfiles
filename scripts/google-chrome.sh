#!/bin/bash

set -eu

paru -S --needed --noconfirm \
    google-chrome \
    intel-media-driver \
    libva-utils \
    intel-gpu-tools
if [[ ! -e ~/.config/chrome-flags.conf ]]; then
    cat <<EOT > ~/.config/chrome-flags.conf
--ignore-gpu-blocklist
--enable-features=VaapiVideoDecodeLinuxGL
EOT
fi
