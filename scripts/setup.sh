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
# .config配下のファイルの置き換え
ln -sf ${BASE_DIR}/.config/environment.d ${HOME}/.config/
ln -sf ${BASE_DIR}/.config/chrome-flags.conf ${HOME}/.config/chrome-flags.conf
# Google Driveの設定
if [[ ! -e ${HOME}/mnt/google-drive ]]; then
    read -n 1 -p "Configure connection for Google Drive? (y/N): " RET
    case ${RET} in
        [yY])
            rclone config create --all google-drive drive \
                scope=drive \
                root_folder_id= \
                service_account_file= \
                team_drive=
            MNT_DIR=${HOME}/mnt/google-drive
            mkdir -p ${MNT_DIR}
            mkdir -p ${HOME}/.config/systemd/user
            MNT_FILE=$(echo ${MNT_DIR} | sed -E 's|^/||;s/-/\\x2d/g;s|/|-|g').mount
            ln -sf ${BASE_DIR}/.config/systemd/user/google-drive.mount ${HOME}/.config/systemd/user/${MNT_FILE}
            systemctl --user daemon-reload
            systemctl --user enable ${MNT_FILE}
            systemctl --user start ${MNT_DIR}
            ;;
    esac
fi
