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
nautilus                    # Dosya yöneticisi
gnome-terminal              # Terminal (arka planda gerekli)
gnome-system-monitor        # Sistem izleyici
gnome-disk-utility          # Disk yönetimi
gnome-calculator            # Hesap makinesi
gnome-calendar              # Takvim
gnome-weather               # Hava durumu
gnome-clocks                # Saat/Alarm
gnome-contacts              # Kişiler
gnome-maps                  # Haritalar
gnome-photos                # Fotoğraflar
eog                         # Resim görüntüleyici
evince                      # PDF okuyucu
file-roller                 # Arşiv yöneticisi
gnome-screenshot            # Ekran görüntüsü
gnome-font-viewer           # Yazı tipi önizleyici
baobab                      # Disk kullanım analizi
gnome-logs                  # Sistem logları (GUI)
gnome-characters            # Karakter haritası
gnome-remote-desktop        # Uzak masaüstü
gnome-connections           # Bağlantılar

# ═══════════════════════════════════════════
# GNOME ARAÇLARI VE ÖZELLEŞTİRME
# ═══════════════════════════════════════════
gnome-tweaks                # İnce ayarlar
gnome-extensions-app        # Eklenti yöneticisi
gnome-shell-extension-appindicator  # Sistem tepsisi

# ═══════════════════════════════════════════
# KULLANICI DOSTU UYGULAMALAR (Terminal Gerektirmez)
# ═══════════════════════════════════════════

# İnternet
firefox                     # Web tarayıcı
firefox-langpacks-tr        # Türkçe Firefox

# Ofis
libreoffice-writer          # Kelime işlemci
libreoffice-calc            # Hesap tablosu
libreoffice-impress         # Sunum
libreoffice-langpack-tr     # Türkçe LibreOffice

# Multimedya
totem                       # Video oynatıcı
rhythmbox                   # Müzik oynatıcı
cheese                      # Webcam
sound-juicer                # CD kopyalama
brasero                     # CD/DVD yazma

# Grafik
shotwell                    # Fotoğraf yönetimi
simple-scan                 # Tarayıcı
drawing                     # Basit resim düzenleme

# İletişim
geary                       # E-posta istemcisi

# Yardımcı
deja-dup                    # Yedekleme (GUI)
gnome-boxes                 # Sanal makine (GUI)
transmission-gtk            # Torrent (GUI)

# ═══════════════════════════════════════════
# SİSTEM ARAÇLARI (GUI)
# ═══════════════════════════════════════════
gparted                     # Disk bölümleme (GUI)
timeshift                   # Sistem yedeği (GUI)
gnome-firmware              # Firmware güncelleyici
flatpak                     # Flatpak desteği
fwupd                       # Firmware güncelleme

# ═══════════════════════════════════════════
# TÜRKÇE DİL DESTEĞİ
# ═══════════════════════════════════════════
langpacks-tr
glibc-langpack-tr
hunspell-tr                 # Türkçe yazım denetimi
hyphen-tr                   # Heceleme

# ═══════════════════════════════════════════
# CODEC VE MULTIMEDYA
# ═══════════════════════════════════════════
gstreamer1-plugins-base
gstreamer1-plugins-good
gstreamer1-plugins-bad-free
gstreamer1-plugins-ugly-free
gstreamer1-plugin-openh264
ffmpeg-free
libavcodec-freeworld

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
-gnome-tour               # İlk açılış turu (kendi turumuz olacak)

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

# os-release dosyası
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

# Issue dosyaları
echo "YmY OS %YMY_VERSION%" > /etc/issue
echo "YmY OS %YMY_VERSION%" > /etc/issue.net

# ═══════════════════════════════════════════
# FLATPAK YAPILANDIRMASI
# ═══════════════════════════════════════════
echo "📦 Flatpak yapılandırılıyor..."

# Flathub ekle
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Kullanışlı Flatpak uygulamaları (isteğe bağlı - GUI'den de yüklenebilir)
# flatpak install -y flathub com.spotify.Client
# flatpak install -y flathub com.discordapp.Discord

# ═══════════════════════════════════════════
# DNF YAPILANDIRMASI (Hızlı indirme)
# ═══════════════════════════════════════════
echo "⚙️ DNF yapılandırılıyor..."

cat >> /etc/dnf/dnf.conf << 'EOF'
# YmY OS DNF Ayarları
max_parallel_downloads=10
fastestmirror=True
deltarpm=True
defaultyes=True
EOF

# ═══════════════════════════════════════════
# GNOME AYARLARI (Kullanıcı Dostu)
# ═══════════════════════════════════════════
echo "🖥️ GNOME ayarları yapılandırılıyor..."

# Sistem geneli dconf ayarları
mkdir -p /etc/dconf/db/local.d
mkdir -p /etc/dconf/profile

# dconf profili
cat > /etc/dconf/profile/user << 'EOF'
user-db:user
system-db:local
EOF

# GNOME masaüstü ayarları
cat > /etc/dconf/db/local.d/00-ymy-os << 'EOF'
# YmY OS GNOME Varsayılan Ayarları
# Yeni başlayanlar için optimize edilmiş

[org/gnome/desktop/interface]
# Koyu tema (göz yormuyor)
color-scheme='prefer-dark'
# Türkçe
gtk-theme='Adwaita-dark'
icon-theme='Adwaita'
# Büyük yazı tipi (okunabilirlik)
font-name='Cantarell 11'
document-font-name='Cantarell 11'
monospace-font-name='Source Code Pro 10'
# Saat formatı
clock-format='24h'
clock-show-date=true
clock-show-weekday=true
# Animasyonları aktif tut (modern görünüm)
enable-animations=true

[org/gnome/desktop/wm/preferences]
# Pencere düğmeleri (minimize, maximize ekle)
button-layout='appmenu:minimize,maximize,close'
# Başlık çubuğu yazı tipi
titlebar-font='Cantarell Bold 11'

[org/gnome/mutter]
# Köşe pencere yapıştırma
edge-tiling=true
# Dinamik çalışma alanları
dynamic-workspaces=true

[org/gnome/shell]
# Favori uygulamalar (dock'ta görünecekler)
favorite-apps=['org.gnome.Nautilus.desktop', 'firefox.desktop', 'org.gnome.Software.desktop', 'libreoffice-writer.desktop', 'org.gnome.Settings.desktop']

[org/gnome/desktop/privacy]
# Gizlilik ayarları (kullanıcı dostu varsayılanlar)
remember-recent-files=true
recent-files-max-age=30
remove-old-trash-files=true
remove-old-temp-files=true
old-files-age=30

[org/gnome/desktop/notifications]
# Bildirimler
show-banners=true
show-in-lock-screen=false

[org/gnome/settings-daemon/plugins/power]
# Güç ayarları (dizüstü için uygun)
sleep-inactive-ac-timeout=1800
sleep-inactive-battery-timeout=900
power-button-action='interactive'

[org/gnome/desktop/session]
# Oturum
idle-delay=300

[org/gnome/desktop/screensaver]
# Ekran koruyucu
lock-enabled=true
lock-delay=30

[org/gnome/desktop/peripherals/touchpad]
# Touchpad ayarları (dizüstü kullanıcıları için)
tap-to-click=true
two-finger-scrolling-enabled=true
natural-scroll=true

[org/gnome/desktop/peripherals/mouse]
# Fare ayarları
natural-scroll=false

[org/gnome/nautilus/preferences]
# Dosya yöneticisi
default-folder-viewer='icon-view'
show-hidden-files=false
show-delete-permanently=false

[org/gnome/nautilus/icon-view]
default-zoom-level='medium'

[org/gnome/software]
# Yazılım merkezi
download-updates=true
download-updates-notify=true
first-run=false

[org/gnome/desktop/search-providers]
# Arama sağlayıcıları
sort-order=['org.gnome.Settings.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Software.desktop']

[org/gnome/desktop/input-sources]
# Klavye düzenleri
sources=[('xkb', 'tr'), ('xkb', 'us')]
xkb-options=['grp:alt_shift_toggle']
EOF

# dconf veritabanını güncelle
dconf update

# ═══════════════════════════════════════════
# GNOME EKLENTİLERİ
# ═══════════════════════════════════════════
echo "🔌 GNOME eklentileri hazırlanıyor..."

# Eklentiler için sistem dizini
mkdir -p /usr/share/gnome-shell/extensions

# Not: Eklentiler Flatpak veya GNOME Extensions uygulamasından yüklenebilir
# Burada sistem geneli kurulum için hazırlık yapıyoruz

# Önerilen eklentiler listesi (kullanıcı tarafından yüklenecek)
cat > /usr/share/ymy-os/recommended-extensions.txt << 'EOF'
# YmY OS Önerilen GNOME Eklentileri
# Bu eklentileri "Eklentiler" uygulamasından yükleyebilirsiniz

1. Dash to Dock - Dock çubuğunu özelleştirin
   https://extensions.gnome.org/extension/307/dash-to-dock/

2. AppIndicator Support - Sistem tepsisi simgeleri
   (Zaten yüklü)

3. Blur My Shell - Bulanık arka plan efektleri
   https://extensions.gnome.org/extension/3193/blur-my-shell/

4. Just Perfection - GNOME Shell özelleştirme
   https://extensions.gnome.org/extension/3843/just-perfection/

5. Clipboard History - Pano geçmişi
   https://extensions.gnome.org/extension/4839/clipboard-history/

6. GSConnect - Telefon entegrasyonu (KDE Connect)
   https://extensions.gnome.org/extension/1319/gsconnect/
EOF

# ═══════════════════════════════════════════
# HOŞGELDİN MESAJI VE YARDIM
# ═══════════════════════════════════════════
echo "📚 Hoşgeldin içeriği oluşturuluyor..."

# YmY OS dizini
mkdir -p /usr/share/ymy-os
mkdir -p /usr/share/ymy-os/docs

# Hoşgeldin belgesi
cat > /usr/share/ymy-os/docs/hosgeldiniz.html << 'EOF'
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>YmY OS'a Hoşgeldiniz!</title>
    <style>
        body {
            font-family: 'Cantarell', sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background: #1e1e1e;
            color: #ffffff;
        }
        h1 { color: #3584e4; }
        h2 { color: #62a0ea; }
        .tip {
            background: #2d2d2d;
            padding: 15px;
            border-left: 4px solid #3584e4;
            margin: 15px 0;
        }
        a { color: #62a0ea; }
    </style>
</head>
<body>
    <h1>🎉 YmY OS'a Hoşgeldiniz!</h1>
    
    <p>Linux dünyasına adım attığınız için tebrikler! YmY OS, yeni başlayanlar için 
    özellikle tasarlanmış, kullanımı kolay bir işletim sistemidir.</p>
    
    <h2>🚀 Başlarken</h2>
    <div class="tip">
        <strong>Uygulama Yüklemek:</strong> Sol üst köşedeki "Etkinlikler"e tıklayın, 
        "Yazılım" yazın ve Yazılım Merkezi'ni açın. Buradan tüm uygulamaları 
        kolayca yükleyebilirsiniz.
    </div>
    
    <h2>📱 Önerilen Uygulamalar</h2>
    <ul>
        <li><strong>Spotify:</strong> Müzik dinlemek için</li>
        <li><strong>Discord:</strong> Arkadaşlarla iletişim</li>
        <li><strong>VLC:</strong> Video oynatıcı</li>
        <li><strong>GIMP:</strong> Resim düzenleme</li>
    </ul>
    
    <h2>❓ Yardım</h2>
    <p>Sorun yaşarsanız:</p>
    <ul>
        <li><a href="https://github.com/ymy-studios/ymy-os/discussions">Topluluk Forumu</a></li>
        <li><a href="https://github.com/ymy-studios/ymy-os/wiki">Wiki</a></li>
    </ul>
    
    <p><em>YmY OS %YMY_VERSION% - Fedora tabanlı</em></p>
</body>
</html>
EOF

# ═══════════════════════════════════════════
# SERVİSLER
# ═══════════════════════════════════════════
echo "⚙️ Servisler yapılandırılıyor..."

# Temel servisler
systemctl enable gdm
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups
systemctl enable fwupd

# Opsiyonel servisler
systemctl enable power-profiles-daemon 2>/dev/null || true

# ═══════════════════════════════════════════
# TEMİZLİK
# ═══════════════════════════════════════════
echo "🧹 Temizlik yapılıyor..."

# DNF cache temizle
dnf clean all

# Gereksiz dosyaları temizle
rm -rf /var/cache/dnf/*
rm -rf /var/log/*.log
rm -rf /tmp/*
rm -rf /root/.cache/*

# Anaconda loglarını temizle
rm -rf /root/anaconda-ks.cfg
rm -rf /root/original-ks.cfg

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║        ✅ YmY OS Kurulum Tamamlandı!                       ║"
echo "║                                                            ║"
echo "║   Sürüm: %YMY_VERSION%                                     ║"
echo "║   Kod Adı: %YMY_CODENAME%                                  ║"
echo "║                                                            ║"
echo "║   GitHub: https://github.com/ymy-studios/ymy-os            ║"
echo "╚════════════════════════════════════════════════════════════╝"

%end

#############################################
# POST - NOCHROOT (Branding dosyaları)
#############################################
%post --nochroot --log=/mnt/sysimage/root/ymy-branding.log

echo "🎨 Branding dosyaları kopyalanıyor..."

# Branding dizini oluştur
mkdir -p /mnt/sysimage/usr/share/ymy-os/branding

# Logo ve görselleri kopyala
if [ -d /run/install/repo/branding ]; then
    cp -r /run/install/repo/branding/* /mnt/sysimage/usr/share/ymy-os/branding/
fi

# Pixmaps için logo
mkdir -p /mnt/sysimage/usr/share/pixmaps
if [ -f /mnt/sysimage/usr/share/ymy-os/branding/logos/ymy-logo-256.png ]; then
    cp /mnt/sysimage/usr/share/ymy-os/branding/logos/ymy-logo-256.png /mnt/sysimage/usr/share/pixmaps/ymy-logo.png
fi

echo "✅ Branding tamamlandı"

%end
