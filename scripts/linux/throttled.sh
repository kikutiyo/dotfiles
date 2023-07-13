#!/bin/bash

set -eu

paru -S --needed --noconfirm throttled
sudo systemctl enable --now throttled
