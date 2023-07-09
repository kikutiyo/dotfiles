#!/bin/bash

set -eu

CONF_DIR=~/.config/environment.d
CONF_FILE=${CONF_DIR}/im.conf

paru -S --needed --noconfirm \
    fcitx5-im \
    mozc-ut \
    fcitx5-mozc-ut

if [[ ! -f ${CONF_FILE} ]]; then
    if [[ ! -d ${CONF_DIR} ]]; then
        mkdir -p ${CONF_DIR}
    fi
    cat <<EOT > ${CONF_FILE}
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
EOT
fi
