#!/bin/bash

set -eu

# 分数スケーリング対応版mutter,gnome-control-centerに置き換え
paru -S --needed --batchinstall \
    mutter-x11-scaling \
    gnome-control-center-x11-scaling

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
# 分数スケーリングを許可・X11セッション終了時にXwaylandを自動終了
gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer', 'autoclose-xwayland']"
# フォント設定
gsettings set org.gnome.desktop.interface document-font-name 'Noto Sans CJK JP DemiLight 11'
gsettings set org.gnome.desktop.interface font-name 'Noto Sans CJK JP DemiLight 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'HackGen Regular 11'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Noto Sans CJK JP DemiLight 11'

# gnome-extensions-cliのインストール
paru -S --needed --noconfirm python-pipx
pipx install gnome-extensions-cli
# 機能拡張のインストール
gext install \
    kimpanel@kde.org \
    cloudflare-warp-toggle@khaled.is-a.dev \
    battery-indicator-icon@Deminder \
	blur-my-shell@aunetx \
	WallpaperSwitcher@Rishu \
	caffeine@patapon.info \
    autohide-battery@sitnik.ru \
    compiz-alike-magic-lamp-effect@hermes83.github.com

# ホームディレクトリ配下のフォルダ名を英名に変更
LANG=C xdg-user-dirs-gtk-update
