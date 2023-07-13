#!/bin/bash

set -eu

paru -S --needed --noconfirm solaar
if [[ -e /usr/share/applications/solaar.desktop ]]; then
    sed -E 's/^(Exec=.*solaar)/\1 --window=hide/' \
        /usr/share/applications/solaar.desktop > ~/.config/autostart/solaar.desktop
fi
