#!/bin/bash

# リッドの開閉状態を返すデバイスファイルのフルパス
LID_STATE=/proc/acpi/button/lid/LID/state
# モジュール設定の変更対象ファイル名（スペース区切りで列挙）
PAM_CONF="/etc/pam.d/polkit-1 /etc/pam.d/sudo"

is_disabled_pam_fprintd() {
    grep -q '^#\+.*pam_fprintd\.so.*' $1
    return $?
}

case "$(sed -E 's/^state:\s+//' ${LID_STATE})" in
    open)
        for CONF in ${PAM_CONF}; do
            is_disabled_pam_fprintd ${CONF} && {
                echo "Enable pam_fprintd.so on ${CONF}."
                sed -i -E 's/^#+(.*pam_fprintd\.so.*)/\1/' ${CONF}
            }
        done
        ;;
    closed)
        for CONF in ${PAM_CONF}; do
            is_disabled_pam_fprintd ${CONF} || {
                echo "Disable pam_fprintd.so on ${CONF}."
                sed -i -E 's/^(.*pam_fprintd\.so.*)/#\1/' ${CONF}
            }
        done
        ;;
esac
exit 0
