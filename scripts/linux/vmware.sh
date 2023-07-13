#!/bin/bash

set -eu

HEADER_PKGS=$(sudo pacman -Qq linux | sed -E 's/$/-headers/')
paru -S --needed --noconfirm \
    ${HEADER_PKGS} \
    vmware-workstation
sudo systemctl enable --now \
    vmware-networks.service \
    vmware-usbarbitrator.service
sudo modprobe -a vmw_vmci vmmon
