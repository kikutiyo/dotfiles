#!/bin/bash

set -eu

BASE_DIR=$(cd $(dirname $0)/.. && pwd)

# zpreztoのインストール
if [[ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi
# zsh rcファイルの置き換え
RC_DIR=$(cd ${BASE_DIR}/zsh && pwd)
for RC_FILE in $(ls ${RC_DIR}); do
    ln -sf ${RC_DIR}/${RC_FILE} ${HOME}/.${RC_FILE}
done
