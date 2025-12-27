# kickstart/ymy-os.ks
# YmY OS - Yeni Başlayanlar İçin Linux
# Fedora %FEDORA_VERSION% Tabanlı

#version=DEVEL

#############################################
# TEMEL SİSTEM AYARLARI
#############################################

# Grafik kurulum
graphical

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

# X Window
xconfig --startxonboot

# Bootloader
bootloader --location=mbr --timeout=5 --append="rhgb quiet"

# Disk yapılandırması
zerombr
clearpart --all --initlabel
autopart --type=plain

# İlk açılış
firstboot --enable

# Yeniden başlat
reboot --eject

#############################################
# KULLANICI
#############################################

# Root devre dışı (güvenlik için)
rootpw --lock

# Live kullanıcı
user --name=ymy --groups=wheel --password=ymy --plaintext --gecos="YmY OS Kullanıcısı"

#############################################
# DEPOLAR
#############################################

# Fedora ana depo
url --mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=fedora-$releasever&arch=$basearch

# Fedora güncellemeler
repo --name=fedora-updates --mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=updates-released-f$releasever&arch=$basearch

# RPM Fusion Free
repo --name=rpmfusion-free --mirrorlist=https://mirrors.rpmfusion.org/metalink?repo=free-fedora-$releasever&arch=$basearch

# RPM Fusion Non-Free
repo --name=rpmfusion-nonfree --mirrorlist=https://mirrors.rpmfusion.org/metalink?repo=nonfree-fedora-$releasever&arch=$basearch

#############################################
# PAKETLER
#############################################
%packages

# ═══════════════════════════════════════════
# LIVE ISO İÇİN GEREKLİ PAKETLER (ÖNEMLİ!)
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
@base-x
@fonts
@hardware-support
@multimedia
@networkmanager-submodules
@printing

# ═══════════════════════════════════════════
# GNOME MASAÜSTÜ
# ═══════════════════════════════════════════
@gnome-desktop
gdm
gnome-shell
gnome-session
gnome-control-center
gnome-settings-daemon
gnome-initial-setup
gnome-software
gnome-software-plugin-flatpak

# GNOME Temel Uygulamalar
nautilus
gnome-terminal
gnome-system-monitor
gnome-disk-utility
gnome-calculator
gnome-calendar
gnome-weather
gnome-clocks
gnome-contacts
gnome-maps
gnome-photos
eog
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
# GNOME ARAÇLARI VE ÖZELLEŞTİRME
# ═══════════════════════════════════════════
gnome-tweaks
gnome-extensions-app
gnome-shell-extension-appindicator

# ═══════════════════════════════════════════
# KULLANICI DOSTU UYGULAMALAR
# ═══════════════════════════════════════════

# İnternet
firefox
firefox-langpacks-tr

# Ofis
libreoffice-writer
libreoffice-calc
libreoffice-impress
libreoffice-langpack-tr

# Multimedya
totem
rhythmbox
cheese
sound-juicer
brasero

# Grafik
shotwell
simple-scan
drawing

# İletişim
geary

# Yardımcı
deja-dup
gnome-boxes
transmission-gtk

# ═══════════════════════════════════════════
# SİSTEM ARAÇLARI (GUI)
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

# ═══════════════════════════════════════════
# SÜRÜCÜLER
# ═══════════════════════════════════════════
mesa-dri-drivers
mesa-vulkan-drivers
mesa-va-drivers
intel-media-driver
libva-intel-driver

# ═══════════════════════════════════════════
# FONTLAR
# ═══════════════════════════════════════════
google-noto-fonts-common
google-noto-sans-fonts
google-noto-serif-fonts
google-noto-emoji-fonts
mozilla-fira-fonts-common
adobe-source-code-pro-fonts
dejavu-fonts-all

# ═══════════════════════════════════════════
# KALDIRILACAK PAKETLER
# ═══════════════════════════════════════════
-@dial-up
-@input-methods
-fedora-release-notes
-gnome-tour

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
echo "╚════════════════════════════════════════════════════════════╝"

# ═══════════════════════════════════════════
# YmY OS BRANDING
# ═══════════════════════════════════════════
echo "🎨 Branding yapılandırılıyor..."

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
# FLATPAK YAPILANDIRMASI
# ═══════════════════════════════════════════
echo "📦 Flatpak yapılandırılıyor..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# ═══════════════════════════════════════════
# DNF YAPILANDIRMASI
# ═══════════════════════════════════════════
echo "⚙️ DNF yapılandırılıyor..."

cat >> /etc/dnf/dnf.conf << 'EOF'
max_parallel_downloads=10
fastestmirror=True
deltarpm=True
defaultyes=True
EOF

# ═══════════════════════════════════════════
# GNOME AYARLARI
# ═══════════════════════════════════════════
echo "🖥️ GNOME ayarları yapılandırılıyor..."

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
document-font-name='Cantarell 11'
monospace-font-name='Source Code Pro 10'
clock-format='24h'
clock-show-date=true
clock-show-weekday=true
enable-animations=true

[org/gnome/desktop/wm/preferences]
button-layout='appmenu:minimize,maximize,close'
titlebar-font='Cantarell Bold 11'

[org/gnome/mutter]
edge-tiling=true
dynamic-workspaces=true

[org/gnome/shell]
favorite-apps=['org.gnome.Nautilus.desktop', 'firefox.desktop', 'org.gnome.Software.desktop', 'libreoffice-writer.desktop', 'org.gnome.Settings.desktop']

[org/gnome/desktop/privacy]
remember-recent-files=true
recent-files-max-age=30
remove-old-trash-files=true
remove-old-temp-files=true
old-files-age=30

[org/gnome/settings-daemon/plugins/power]
sleep-inactive-ac-timeout=1800
sleep-inactive-battery-timeout=900
power-button-action='interactive'

[org/gnome/desktop/session]
idle-delay=300

[org/gnome/desktop/peripherals/touchpad]
tap-to-click=true
two-finger-scrolling-enabled=true
natural-scroll=true

[org/gnome/nautilus/preferences]
default-folder-viewer='icon-view'
show-hidden-files=false

[org/gnome/software]
download-updates=true
download-updates-notify=true
first-run=false
EOF

dconf update

# ═══════════════════════════════════════════
# SERVİSLER
# ═══════════════════════════════════════════
echo "⚙️ Servisler yapılandırılıyor..."

systemctl enable gdm
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups
systemctl enable fwupd

# ═══════════════════════════════════════════
# LIVE SİSTEM AYARLARI
# ═══════════════════════════════════════════
echo "💿 Live sistem ayarları yapılıyor..."

# Live user için otomatik giriş
cat > /etc/gdm/custom.conf << 'EOF'
[daemon]
AutomaticLoginEnable=True
AutomaticLogin=ymy

[security]

[xdmcp]

[chooser]

[debug]
EOF

# Sudo şifresiz (live ortam için)
echo "ymy ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/ymy-live

# ═══════════════════════════════════════════
# TEMİZLİK
# ═══════════════════════════════════════════
echo "🧹 Temizlik yapılıyor..."

dnf clean all
rm -rf /var/cache/dnf/*
rm -rf /var/log/*.log
rm -rf /tmp/*

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║        ✅ YmY OS Kurulum Tamamlandı!                       ║"
echo "║                                                            ║"
echo "║   Sürüm: %YMY_VERSION%                                     ║"
echo "║   GitHub: https://github.com/ymy-studios/ymy-os            ║"
echo "╚════════════════════════════════════════════════════════════╝"

%end

#############################################
# POST - NOCHROOT
#############################################
%post --nochroot --log=/mnt/sysimage/root/ymy-branding.log

echo "🎨 Branding dosyaları kopyalanıyor..."

mkdir -p /mnt/sysimage/usr/share/ymy-os/branding

if [ -d /run/install/repo/branding ]; then
    cp -r /run/install/repo/branding/* /mnt/sysimage/usr/share/ymy-os/branding/
fi

mkdir -p /mnt/sysimage/usr/share/pixmaps
if [ -f /mnt/sysimage/usr/share/ymy-os/branding/logos/ymy-logo-256.png ]; then
    cp /mnt/sysimage/usr/share/ymy-os/branding/logos/ymy-logo-256.png /mnt/sysimage/usr/share/pixmaps/ymy-logo.png
fi

echo "✅ Branding tamamlandı"

%end
