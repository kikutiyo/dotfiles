#!/bin/bash

set -eu

paru -S --needed --noconfirm rclone

read -n 1 -p "Configure connection for Google Drive? (y/N): " RET
case ${RET} in
    [yY])
        rclone config create --all gdrive drive \
            scope=drive \
            root_folder_id= \
            service_account_file= \
            team_drive=
        mkdir -p ~/mnt/gdrive
        mkdir -p ~/.config/systemd/user
        MOUNT_FILE=$(echo ${HOME} | cut -c2- | sed -E 's|/|-|g')-mnt-gdrive.mount
        ln -s $(cd $(dirname $0)/../.. && pwd)/xdg_config/systemd/user/gdrive.mount ~/.config/systemd/user/${MOUNT_FILE}
        systemctl --user daemon-reload
        systemctl --user enable ${MOUNT_FILE}
        systemctl --user start ~/mnt/gdrive
        ;;
esac
