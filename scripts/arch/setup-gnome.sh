#!/bin/bash

set -eu

# CapsLockをCtrlにする（CapsLockは無効化）
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"
# トラックパッドのタップでクリックを無効化
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click false
# 無操作時のディスプレイOFFまでの時間を15分に設定
gsettings set org.gnome.desktop.session idle-delay 900
# 電源ボタン押下時はハイバネートする
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'hibernate'
# AC稼働時は1時間でサスペンド
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 3600
# バッテリー稼働時は30分でサスペンド
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 1800
# ナイトモードを時間指定
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false
# 23:00からナイトモードを開始
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 23.0
# 5:00でナイトモードを終了
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 5.0
# 100%以上の音量を許可
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
# 新しいウィンドウを開く際に画面中央に表示
gsettings set org.gnome.mutter center-new-windows true
# バッテリーのパーセント表示を有効化
gsettings set org.gnome.desktop.interface show-battery-percentage true

# ダークモードに変更
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# フォント設定
gsettings set org.gnome.desktop.interface document-font-name 'Noto Sans CJK JP DemiLight 11'
gsettings set org.gnome.desktop.interface font-name 'Noto Sans CJK JP DemiLight 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'HackGen Regular 11'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Noto Sans CJK JP DemiLight 11'

# GTK+アプリ用テーマを設定
paru -S --needed --noconfirm --sudoloop adw-gtk3
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'

# Papirusアイコンを設定
paru -S --needed --noconfirm --sudoloop \
    papirus-icon-theme \
    papirus-folders
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'

# Capitaineカーソルを設定
paru -S --needed --noconfirm --sudoloop capitaine-cursors
gsettings set org.gnome.desktop.interface cursor-theme 'capitaine-cursors'

# gnome-extensions-cliのインストール
paru -S --needed --noconfirm --sudoloop python-pipx
pipx install gnome-extensions-cli
# 機能拡張のインストール
${HOME}/.local/bin/gext install \
    appindicatorsupport@rgcjonas.gmail.com \
    autohide-battery@sitnik.ru \
    battery-indicator-icon@Deminder \
    blur-my-shell@aunetx \
    caffeine@patapon.info \
    cloudflare-warp-toggle@khaled.is-a.dev \
    compiz-alike-magic-lamp-effect@hermes83.github.com \
    custom-accent-colors@demiskp \
    dash-to-dock@micxgx.gmail.com \
    gnome-ui-tune@itstime.tech \
    kimpanel@kde.org \
    legacyschemeautoswitcher@joshimukul29.gmail.com \
    status-area-horizontal-spacing@mathematical.coffee.gmail.com \
    WallpaperSwitcher@Rishu

# ホームディレクトリ配下のフォルダ名を英名に変更
LANG=C xdg-user-dirs-gtk-update
