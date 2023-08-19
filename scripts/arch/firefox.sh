#!/bin/bash

set -eu

paru -S --needed --noconfirm \
    firefox \
    firefox-i18n-ja
cp -v $(dirname $0)/.config/environment.d/firefox.conf ${HOME}/.config/environment.d
