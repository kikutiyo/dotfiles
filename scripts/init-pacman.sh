#!/bin/bash

set -eu

# pamac設定
sudo sed -i -E 's/^#+(EnableAUR|NoUpdateHideIcon)/¥1/' /etc/pamac.conf
# リポジトリミラー設定
sudo pacman-mirrors -c Japan,Taiwan,Singapore
# パッケージ更新
sudo pacman -Syyu --noconfirm
# paruのインストール
sudo pacman -S --needed --noconfirm base-devel
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -si --needed --noconfirm
cd ..
rm -rf paru-bin
