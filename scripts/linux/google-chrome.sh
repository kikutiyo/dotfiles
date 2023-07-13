#!/bin/bash

set -eu

paru -S --needed --noconfirm \
    google-chrome \
    intel-media-driver \
    libva-utils \
    intel-gpu-tools
