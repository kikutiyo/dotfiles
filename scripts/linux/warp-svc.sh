#!/bin/bash

set -eu

paru -S --needed --noconfirm cloudflare-warp-bin
sudo systemctl enable --now warp-svc
