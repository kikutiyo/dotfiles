#!/usr/bin/env bash

set -e

if [[ ! -e /usr/bin/git ]]; then
    echo "Installing Xcode Command Line Tools..."
    xcode-select --install
fi
if [[ -z ${HOMEBREW_PREFIX} ]]; then
    echo "Setting up Homebrew..."
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshenv
fi
