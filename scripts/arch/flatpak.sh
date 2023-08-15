#!/bin/bash

set -eu

sudo pacman -S --needed \
    flatpak \
    xdg-desktop-portal \
    xdg-desktop-portal-gnome
flatpak install --noninteractive \
    com.raggesilver.BlackBox \
    com.github.tchx84.Flatseal \
    ca.desrt.dconf-editor \
    com.mattjakeman.ExtensionManager


