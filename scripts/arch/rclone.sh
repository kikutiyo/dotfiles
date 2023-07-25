#!/bin/nash

set -eu

# インストール
paru -S --needed --noconfirm --sudoloop rclone
# Google Driveの設定
MNT_DIR=${HOME}/mnt/google-drive
if [[ ! -e ${MNT_DIR} ]]; then
    read -n 1 -p "Google Driveの設定を行いますか？ (y/N): " RET
    case ${RET} in
        [yY])
            rclone config create --all google-drive drive \
                scope=drive \
                root_folder_id= \
                service_account_file= \
                team_drive=
            MNT_FILE=$(echo ${MNT_DIR} | sed -E 's|^/||;s/-/\\x2d/g;s|/|-|g').mount
            if [[ ! -e ${HOME}/.config/systemd/user ]]; then
                mkdir -p ${HOME}/.config/systemd/user
            fi
            ln -sf $(cd $(dirname $0)/../.. && pwd)/.config/systemd/user/google-drive.mount ${HOME}/.config/systemd/user/${MNT_FILE}
            systemctl --user daemon-reload
            systemctl --user enable ${MNT_FILE}
            systemctl --user start ${MNT_DIR}
            ;;
    esac
fi
