#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

PLATFORM_SCRIPT="setup_$(uname).sh"
if [[ -f "${DOTFILES_DIR}/${PLATFORM_SCRIPT}" ]]; then
    echo "Running platform-specific setup script: ${PLATFORM_SCRIPT}"
    bash "${DOTFILES_DIR}/${PLATFORM_SCRIPT}"
fi

if [[ ! -e ~/.local/share/zinit/zinit.git ]]; then
    echo "Installing Zinit..."
    bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
fi
if [[ ! -e ~/.config/zsh ]]; then
    echo "Creating Symlink to Zsh config directory..."
    ln -s "$DOTFILES_DIR/.config/zsh" ~/.config/zsh
    echo "export ZDOTDIR=$HOME/.config/zsh" >> ~/.zshenv
fi
test -e ~/.config/starship.toml || ln -s "$DOTFILES_DIR/.config/starship.toml" ~/.config/starship.toml
test -e ~/.config/ghostty || ln -s "$DOTFILES_DIR/.config/ghostty" ~/.config/ghostty
