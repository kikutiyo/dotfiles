#!/bin/bash

set -eu

paru -S --needed --noconfirm 1password
if [[ -e /usr/share/applications/1password.desktop ]]; then
    sed -E 's/(^Exec=.+¥/1password)/\1 --silent/' /usr/share/applications/1password.desktop > ~/.config/autostart/1password.desktop
fi
