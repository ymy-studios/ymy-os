# kickstart/ymy-os.ks
# YmY OS - Yeni Başlayanlar İçin Linux
# Fedora %FEDORA_VERSION% Tabanlı
# GNOME 49 - Wayland Only

#version=DEVEL

#############################################
# TEMEL SİSTEM AYARLARI
#############################################

# Klavye düzeni
keyboard --vckeymap=tr --xlayouts='tr','us' --switch='grp:alt_shift_toggle'

# Sistem dili
lang tr_TR.UTF-8

# Zaman dilimi
timezone Europe/Istanbul --utc

# Ağ yapılandırması
network --bootproto=dhcp --device=link --activate --onboot=yes
network --hostname=ymy-os

# SELinux
selinux --enforcing

# Firewall
firewall --enabled --service=mdns

# Bootloader
bootloader --location=mbr --timeout=5 --append="rhgb quiet"

# Disk yapılandırması
zerombr
clearpart --all --initlabel
autopart --type=plain

# Yeniden başlat
reboot --eject

#############################################
# KULLANICI
#############################################

# Root devre dışı
rootpw --lock

# Live kullanıcı
user --name=ymy --groups=wheel --password=ymy --plaintext --gecos="YmY OS Kullanıcısı"

#############################################
# DEPOLAR
#############################################

url --mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=fedora-$releasever&arch=$basearch
repo --name=fedora-updates --mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=updates-released-f$releasever&arch=$basearch
repo --name=rpmfusion-free --mirrorlist=https://mirrors.rpmfusion.org/metalink?repo=free-fedora-$releasever&arch=$basearch
repo --name=rpmfusion-nonfree --mirrorlist=https://mirrors.rpmfusion.org/metalink?repo=nonfree-fedora-$releasever&arch=$basearch

#############################################
# PAKETLER
#############################################
%packages

# ═══════════════════════════════════════════
# LIVE ISO İÇİN GEREKLİ PAKETLER
# ═══════════════════════════════════════════
dracut-live
dracut-squash
livesys-scripts
anaconda
anaconda-install-env-deps
anaconda-live
@anaconda-tools

# ═══════════════════════════════════════════
# TEMEL SİSTEM
# ═══════════════════════════════════════════
@core
@fonts
@hardware-support
@multimedia
@networkmanager-submodules
@printing

# ═══════════════════════════════════════════
# WAYLAND (GNOME 49+)
# ═══════════════════════════════════════════
# ❌ @base-x kaldırıldı - X11 artık yok
@base-graphical
mutter
egl-wayland
xorg-x11-server-Xwayland
libwayland-client
libwayland-server
libwayland-cursor
libwayland-egl
qt5-qtwayland
qt6-qtwayland

# ═══════════════════════════════════════════
# GNOME MASAÜSTÜ (WAYLAND)
# ═══════════════════════════════════════════
@gnome-desktop
gdm
gnome-shell
gnome-session
gnome-session-wayland-session
gnome-control-center
gnome-settings-daemon
gnome-initial-setup
gnome-software
gnome-software-plugin-flatpak

# GNOME Temel Uygulamalar
nautilus
gnome-terminal
gnome-console
gnome-system-monitor
gnome-disk-utility
gnome-calculator
gnome-calendar
gnome-weather
gnome-clocks
gnome-contacts
gnome-maps
gnome-photos
loupe
evince
file-roller
gnome-screenshot
gnome-font-viewer
baobab
gnome-logs
gnome-characters
gnome-remote-desktop
gnome-connections

# ═══════════════════════════════════════════
# GNOME ÖZELLEŞTİRME
# ═══════════════════════════════════════════
gnome-tweaks
gnome-extensions-app
gnome-shell-extension-appindicator

# ═══════════════════════════════════════════
# UYGULAMALAR
# ═══════════════════════════════════════════
firefox
firefox-langpacks-tr
libreoffice-writer
libreoffice-calc
libreoffice-impress
libreoffice-langpack-tr
totem
rhythmbox
snapshot
shotwell
simple-scan
drawing
geary
deja-dup
gnome-boxes
transmission-gtk

# ═══════════════════════════════════════════
# SİSTEM ARAÇLARI
# ═══════════════════════════════════════════
gparted
timeshift
gnome-firmware
flatpak
fwupd

# ═══════════════════════════════════════════
# TÜRKÇE DİL DESTEĞİ
# ═══════════════════════════════════════════
langpacks-tr
glibc-langpack-tr
hunspell-tr
hyphen-tr

# ═══════════════════════════════════════════
# CODEC VE MULTIMEDYA
# ═══════════════════════════════════════════
gstreamer1-plugins-base
gstreamer1-plugins-good
gstreamer1-plugins-bad-free
gstreamer1-plugins-ugly-free
gstreamer1-plugin-openh264
pipewire
pipewire-pulseaudio
pipewire-alsa
pipewire-jack-audio-connection-kit
wireplumber

# ═══════════════════════════════════════════
# SÜRÜCÜLER (WAYLAND)
# ═══════════════════════════════════════════
mesa-dri-drivers
mesa-vulkan-drivers
mesa-va-drivers
mesa-libEGL
mesa-libGL
mesa-libgbm
intel-media-driver
libva-intel-driver

# ═══════════════════════════════════════════
# FONTLAR
# ═══════════════════════════════════════════
google-noto-fonts-common
google-noto-sans-fonts
google-noto-serif-fonts
google-noto-emoji-fonts
dejavu-fonts-all

# ═══════════════════════════════════════════
# KALDIRILACAK PAKETLER
# ═══════════════════════════════════════════
-@dial-up
-@input-methods
-fedora-release-notes
-gnome-tour
# X11 paketlerini kaldır (gereksiz)
-xorg-x11-server-Xorg
-xorg-x11-drv-*

%end

#############################################
# POST KURULUM
#############################################
%post --log=/root/ymy-post-install.log

#!/bin/bash
set -e

echo "╔════════════════════════════════════════════════════════════╗"
echo "║            YmY OS Post-Installation Script                  ║"
echo "║                    Sürüm: %YMY_VERSION%                     ║"
echo "║                    GNOME 49 - Wayland                       ║"
echo "╚════════════════════════════════════════════════════════════╝"

# ═══════════════════════════════════════════
# YmY OS BRANDING
# ═══════════════════════════════════════════
cat > /etc/os-release << 'EOF'
NAME="YmY OS"
VERSION="%YMY_VERSION%"
ID=ymy-os
ID_LIKE=fedora
VERSION_ID=%YMY_VERSION%
PRETTY_NAME="YmY OS %YMY_VERSION%"
ANSI_COLOR="0;34"
LOGO=ymy-logo
CPE_NAME="cpe:/o:ymy-studios:ymy-os:%YMY_VERSION%"
HOME_URL="https://github.com/ymy-studios/ymy-os"
DOCUMENTATION_URL="https://github.com/ymy-studios/ymy-os/wiki"
SUPPORT_URL="https://github.com/ymy-studios/ymy-os/discussions"
BUG_REPORT_URL="https://github.com/ymy-studios/ymy-os/issues"
VARIANT="Desktop"
VARIANT_ID=desktop
EOF

echo "YmY OS %YMY_VERSION%" > /etc/issue
echo "YmY OS %YMY_VERSION%" > /etc/issue.net

# ═══════════════════════════════════════════
# FLATPAK
# ═══════════════════════════════════════════
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# ═══════════════════════════════════════════
# DNF YAPILANDIRMASI
# ═══════════════════════════════════════════
cat >> /etc/dnf/dnf.conf << 'EOF'
max_parallel_downloads=10
fastestmirror=True
deltarpm=True
defaultyes=True
EOF

# ═══════════════════════════════════════════
# GDM - WAYLAND ZORUNLU
# ═══════════════════════════════════════════
mkdir -p /etc/gdm

cat > /etc/gdm/custom.conf << 'EOF'
[daemon]
AutomaticLoginEnable=True
AutomaticLogin=ymy
# Wayland varsayılan (GNOME 49+ için zaten tek seçenek)
WaylandEnable=true
DefaultSession=gnome-wayland.desktop

[security]

[xdmcp]

[chooser]

[debug]
EOF

# ═══════════════════════════════════════════
# GNOME AYARLARI (WAYLAND)
# ═══════════════════════════════════════════
mkdir -p /etc/dconf/db/local.d
mkdir -p /etc/dconf/profile

cat > /etc/dconf/profile/user << 'EOF'
user-db:user
system-db:local
EOF

cat > /etc/dconf/db/local.d/00-ymy-os << 'EOF'
[org/gnome/desktop/interface]
color-scheme='prefer-dark'
gtk-theme='Adwaita-dark'
icon-theme='Adwaita'
font-name='Cantarell 11'
clock-format='24h'
clock-show-date=true
clock-show-weekday=true
enable-animations=true

[org/gnome/desktop/wm/preferences]
button-layout='appmenu:minimize,maximize,close'

[org/gnome/mutter]
edge-tiling=true
dynamic-workspaces=true
# Wayland için experimental özellikler
experimental-features=['variable-refresh-rate', 'scale-monitor-framebuffer']

[org/gnome/shell]
favorite-apps=['org.gnome.Nautilus.desktop', 'firefox.desktop', 'org.gnome.Software.desktop', 'libreoffice-writer.desktop', 'org.gnome.Settings.desktop']

[org/gnome/desktop/peripherals/touchpad]
tap-to-click=true
two-finger-scrolling-enabled=true
natural-scroll=true

[org/gnome/software]
download-updates=true
download-updates-notify=true
first-run=false

[org/gnome/mutter/wayland]
# Wayland için ek ayarlar
xwayland-grab-access-rules=[]
EOF

dconf update

# ═══════════════════════════════════════════
# SERVİSLER
# ═══════════════════════════════════════════
systemctl enable gdm
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups
systemctl enable fwupd
systemctl enable pipewire
systemctl enable wireplumber

# ═══════════════════════════════════════════
# LIVE SİSTEM
# ═══════════════════════════════════════════
echo "ymy ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/ymy-live

# ═══════════════════════════════════════════
# TEMİZLİK
# ═══════════════════════════════════════════
dnf clean all
rm -rf /var/cache/dnf/*

echo "✅ YmY OS Kurulum Tamamlandı!"

%end

#############################################
# POST - NOCHROOT
#############################################
%post --nochroot --log=/mnt/sysimage/root/ymy-branding.log

mkdir -p /mnt/sysimage/usr/share/ymy-os/branding

if [ -d /run/install/repo/branding ]; then
    cp -r /run/install/repo/branding/* /mnt/sysimage/usr/share/ymy-os/branding/
fi

mkdir -p /mnt/sysimage/usr/share/pixmaps
if [ -f /mnt/sysimage/usr/share/ymy-os/branding/logos/ymy-logo-256.png ]; then
    cp /mnt/sysimage/usr/share/ymy-os/branding/logos/ymy-logo-256.png /mnt/sysimage/usr/share/pixmaps/ymy-logo.png
fi

%end
