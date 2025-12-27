# kickstart/ymy-os.ks
# YmY OS - Yeni Başlayanlar İçin Linux
# Fedora %FEDORA_VERSION% Tabanlı
# GNOME 49 - Wayland Only

#version=DEVEL

#############################################
# TEMEL SİSTEM AYARLARI
#############################################

keyboard --vckeymap=tr --xlayouts='tr','us' --switch='grp:alt_shift_toggle'
lang tr_TR.UTF-8
timezone Europe/Istanbul --utc
network --bootproto=dhcp --device=link --activate --onboot=yes
network --hostname=ymy-os
selinux --enforcing
firewall --enabled --service=mdns
bootloader --location=mbr --timeout=5 --append="rhgb quiet"

#############################################
# DİSK YAPILANDIRMASI
#############################################
zerombr
clearpart --all --initlabel
part / --fstype="ext4" --size=8192

reboot --eject

#############################################
# KULLANICI
#############################################
rootpw --lock
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
# GNOME MASAÜSTÜ
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
# GNOME ÖZELLEŞTİRME ARAÇLARI
# ═══════════════════════════════════════════
gnome-tweaks
gnome-extensions-app

# ═══════════════════════════════════════════
# GNOME EKLENTİLERİ (Yeni Başlayanlar İçin)
# ═══════════════════════════════════════════
# Sistem Tepsisi - Discord, Spotify vb. için şart
gnome-shell-extension-appindicator

# Dock - Ubuntu benzeri alt/yan çubuk (EN ÖNEMLİ!)
gnome-shell-extension-dash-to-dock

# Telefon Bağlantısı - Android telefon entegrasyonu
gnome-shell-extension-gsconnect

# Ekranı Açık Tut - Video izlerken vs. kapanmasın
gnome-shell-extension-caffeine

# Pano Geçmişi - Kopyaladıklarınızı hatırlar
gnome-shell-extension-clipboard-indicator

# Bulanık Efektler - Şık görünüm
gnome-shell-extension-blur-my-shell

# GNOME Özelleştirme - Panel, dock ayarları
gnome-shell-extension-just-perfection

# Arka Plan Logosu - Masaüstünde logo göster
gnome-shell-extension-background-logo

# Pencere Listesi - Alt panelde açık pencereler
gnome-shell-extension-window-list

# Uygulama Menüsü - Klasik uygulama menüsü
gnome-shell-extension-apps-menu

# Yerler Menüsü - Hızlı klasör erişimi
gnome-shell-extension-places-menu

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
wireplumber

# ═══════════════════════════════════════════
# SÜRÜCÜLER
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
# GDM YAPILANDIRMASI
# ═══════════════════════════════════════════
mkdir -p /etc/gdm

cat > /etc/gdm/custom.conf << 'EOF'
[daemon]
AutomaticLoginEnable=True
AutomaticLogin=ymy
WaylandEnable=true
DefaultSession=gnome-wayland.desktop

[security]

[xdmcp]

[chooser]

[debug]
EOF

# ═══════════════════════════════════════════
# GNOME EKLENTİLERİNİ ETKİNLEŞTİR
# ═══════════════════════════════════════════
mkdir -p /etc/dconf/db/local.d
mkdir -p /etc/dconf/profile

cat > /etc/dconf/profile/user << 'EOF'
user-db:user
system-db:local
EOF

cat > /etc/dconf/db/local.d/00-ymy-extensions << 'EOF'
[org/gnome/shell]
# Varsayılan olarak aktif eklentiler
enabled-extensions=['appindicatorsupport@rgcjonas.gmail.com', 'dash-to-dock@micxgx.gmail.com', 'gsconnect@andyholmes.github.io', 'caffeine@pataber.name', 'clipboard-indicator@tudmotu.com', 'blur-my-shell@aunetx', 'just-perfection-desktop@just-perfection', 'background-logo@fedorahosted.org', 'window-list@gnome-shell-extensions.gcampax.github.com', 'apps-menu@gnome-shell-extensions.gcampax.github.com', 'places-menu@gnome-shell-extensions.gcampax.github.com']

# Favori uygulamalar
favorite-apps=['org.gnome.Nautilus.desktop', 'firefox.desktop', 'org.gnome.Software.desktop', 'libreoffice-writer.desktop', 'org.gnome.Settings.desktop', 'org.gnome.Terminal.desktop']
EOF

cat > /etc/dconf/db/local.d/01-ymy-interface << 'EOF'
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
experimental-features=['variable-refresh-rate', 'scale-monitor-framebuffer']

[org/gnome/desktop/peripherals/touchpad]
tap-to-click=true
two-finger-scrolling-enabled=true
natural-scroll=true

[org/gnome/software]
download-updates=true
download-updates-notify=true
first-run=false
EOF

# ═══════════════════════════════════════════
# DASH TO DOCK AYARLARI
# ═══════════════════════════════════════════
cat > /etc/dconf/db/local.d/02-ymy-dash-to-dock << 'EOF'
[org/gnome/shell/extensions/dash-to-dock]
# Dock konumu (sol, alt, sağ)
dock-position='BOTTOM'
# Dock genişliği
dash-max-icon-size=48
# Otomatik gizle
autohide=true
intellihide=true
# Şeffaflık
transparency-mode='DYNAMIC'
background-opacity=0.8
# Tıklama davranışı
click-action='focus-or-previews'
# Çöp kutusu ve bağlı diskler
show-trash=true
show-mounts=true
# Uygulama göstergeleri
running-indicator-style='DOTS'
EOF

# ═══════════════════════════════════════════
# BLUR MY SHELL AYARLARI
# ═══════════════════════════════════════════
cat > /etc/dconf/db/local.d/03-ymy-blur << 'EOF'
[org/gnome/shell/extensions/blur-my-shell]
brightness=0.6
sigma=30

[org/gnome/shell/extensions/blur-my-shell/panel]
blur=true
brightness=0.75

[org/gnome/shell/extensions/blur-my-shell/overview]
blur=true
EOF

# ═══════════════════════════════════════════
# JUST PERFECTION AYARLARI
# ═══════════════════════════════════════════
cat > /etc/dconf/db/local.d/04-ymy-perfection << 'EOF'
[org/gnome/shell/extensions/just-perfection]
# Animasyonlar
animation=2
# Saat konumu
clock-menu-position=1
# Aktiviteler butonu
activities-button=true
# Arama
search=true
# Bildirimler
notification-banner-position=2
EOF

# ═══════════════════════════════════════════
# GSCONNECT AYARLARI
# ═══════════════════════════════════════════
cat > /etc/dconf/db/local.d/05-ymy-gsconnect << 'EOF'
[org/gnome/shell/extensions/gsconnect]
show-indicators=true
EOF

# dconf veritabanını güncelle
dconf update

# ═══════════════════════════════════════════
# SERVİSLER
# ═══════════════════════════════════════════
systemctl enable gdm
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups
systemctl enable fwupd

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
