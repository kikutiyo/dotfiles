#!/bin/bash

set -eu

sudo pacman -S --needed \
    flatpak \
    xdg-desktop-portal \
    xdg-desktop-portal-gnome
flatpak install --noninteractive \
    ca.desrt.dconf-editor \
    com.github.tchx84.Flatseal \
    com.mattjakeman.ExtensionManager \
    com.raggesilver.BlackBox \
    io.github.giantpinkrobots.flatsweep
