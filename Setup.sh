#!/bin/sh

##############################################################################
##  Source: https://github.com/Sejoslaw/OpenBSD-Setup
##
##
##  OpenBSD Configuration Script by Krzysztof "Sejoslaw" Dobrzynski
##
##
##  Current script will allows you to setup: 
##      - basic graphical environment
##      - common services
##      - core tools (console + graphical)
##      - optional tools (music, video, web browser, etc.)
##############################################################################

# Core / Static variables

_etcLoginConfPath=/etc/login.conf
_etcDoasConfPath=/etc/doas.conf

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##              Welcome to OpenBSD-Setup Script               ##"
echo "##                                                            ##"
echo "##  During setup you will be promped for some user-specific   ##"
echo "##  configuration to make the system most optimized for you.  ##"
echo "##  Make sure the script is run directly after a fresh        ##"
echo "##  installation of OpenBSD.                                  ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

sleep 7

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                       Updating OS...                       ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

sysupgrade

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                      Setting up pkg...                     ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

pkg_add -u

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                     Setting up User...                     ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Specify username for which to configure your OS? (username)"
read _user;

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                     Setting up doas...                     ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

useradd -G wheel $_user

echo "" >> $_etcDoasConfPath
echo "# Added by OpenBSD-Setup script" >> $_etcDoasConfPath
echo "permit :wheel" >> $_etcDoasConfPath
echo "# End Added by OpenBSD-Setup script" >> $_etcDoasConfPath

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##             Setting up Desktop Environment...              ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Currently there are a couple of supported Desktop Environments:"
echo "  - gnome -> Full GNOME environment"

echo "Which one: "
read _desktopEnv;

pkg_add $_desktopEnv

if [ "$_desktopEnv" = "gnome" ]
then
    echo "# Added by OpenBSD-Setup script" >> _etcLoginConfPath
    echo "gnome:\\" >> _etcLoginConfPath
    echo "      :datasize-cur=1024M:\\" >> _etcLoginConfPath
    echo "      :tc=default:" >> _etcLoginConfPath
    echo "" >> _etcLoginConfPath
    echo "gdm:\\" >> _etcLoginConfPath
    echo "      :tc=xenodm:" >> _etcLoginConfPath
    echo "# End Added by OpenBSD-Setup script" >> _etcLoginConfPath

    usermod -L gnome $_user

    rcctl disable xenodm
    rcctl enable multicast messagebus avahi_daemon gdm
    
    pkg_add gedit gnome-terminal nautilus baobab deja-dup
fi

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                    Setting up Tools...                     ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Install core tools (nano, htop, neofetch, usbutils, dmidecode, ddrescue, llama, ksnip)? (yes/no): "
read _shouldInstallCoreTools;

if [ "$_shouldInstallCoreTools" = "yes" ]
then
    pkg_add nano htop neofetch usbutils dmidecode ddrescue llama ksnip

    if [ "$_user" != "" ]
    then
        _shrcFilePath=/home/$_user/.kshrc

        echo "" >> $_shrcFilePath
        echo "# Added by OpenBSD-Setup script" >> $_shrcFilePath
        echo "neofetch" >> $_shrcFilePath
        echo "# End Added by OpenBSD-Setup script" >> $_shrcFilePath
    fi
fi

echo "Install common tools (flameshot, dconf-editor, inkscape, Virtual Machine Manager (virt-manager), QEMU, remotebox, virt-viewer)? (yes/no)"
read _shouldInstallCommonTools;

if [ "$_shouldInstallCommonTools" = "yes" ]
then
    pkg_add flameshot dconf-editor inkscape virt-manager qemu remotebox virt-viewer
fi

echo "Install Web Browser (firefox/chromium)? (empty for none)"
read _webBrowser;

if [ "$_webBrowser" != "" ]
then
    pkg_add $_webBrowser
fi

echo "Install AppManager - graphical interface for the OpenBSD package manager? (yes/no)"
read _appManager;

if [ "$_appManager" = "yes" ]
then
    pkg_add appmanager
fi

echo "Configure Cloud Tools (AWS, Kubernetes, GCloud, etc.)? (yes/no)"
read _cloudTools;

if [ "$_cloudTools" = "yes" ]
then
    pkg_add awscli cloud-agent google-cloud-sdk packer
fi

echo "Configure FUSE/FS? (yes/no)"
read _fuse;

if [ "$_fuse" = "yes" ]
then
    pkg_add curlftpfs dosfstools e2fsprogs exfat-fuse mtools ntfs-3g squashfs-tools sshfs-fuse fuse-zip encfs
fi

echo "Configure Converters? (yes/no)"
read _conv;

if [ "$_conv" = "yes" ]
then
    pkg_add bchunk
fi

echo "Configure Reverse Engineering Tools? (yes/no)"
read _revEng;

if [ "$_revEng" = "yes" ]
then
    pkg_add rizin binwalk ghidra
fi

echo "Configure Containers? (yes/no)"
read _containers;

if [ "$_containers" = "yes" ]
then
    pkg_add docker-cli kubectl oc serf terraform jailkit
fi

echo "Configure PCB/Modeling-related tools? (yes/no)"
read _pcb;

if [ "$_pcb" = "yes" ]
then
    pkg_add kicad lepton-eda librecad oce openscad pcb2gcode qcad
fi

echo "Configure productivity tools? (yes/no)"
read _pcb;

if [ "$_pcb" = "yes" ]
then
    pkg_add kicad projectlibre impressive gnucash gnucash-docs
fi

echo "Choose editor: zile, texworks, teaqt, qscintilla, poke, neovim-qt, libreoffice, leafpad, hexedit, hexcurse, focuswriter, featherpad, emacs, abiword - empty for none"
read _editor;

if [ "$_editor" != "" ]
then
    pkg_add $_editor
fi

echo "Configure archive-related tools? (yes/no)"
read _archive;

if [ "$_archive" = "yes" ]
then
    pkg_add zstd zip xz unzip unrar unarr unarj snappy sltar rzip quazip p7zip minizip lzop lz4 lzo2 lrzip deco bzip2 arc
fi

echo "Configure multimedia-related tools? (yes/no)"
read _multimedia;

if [ "$_multimedia" = "yes" ]
then
    pkg_add lmms shotcut vlc krita krita-gmic-plugin inkscape ffmpeg sk1 pixelorama gimp opencv openbsd-backgrounds ocrad mypaint mypaint-brushes mypaint-brushes2 img2pdf ImageMagick GraphicsMagick gif2png flameshot darktable cadubi audacious-player ncspot lmms openal rhythmbox freealut flac audacity alac_decoder celt gsm libvorbis mac opencore-amr opus speex wavpack
fi

echo "Configure printer tools? (yes/no)"
read _printer;

if [ "$_printer" = "yes" ]
then
    pkg_add brlaser cups-pk-helper cups-bjnp cups cups-filters cups-pdf foomatic-db foomatic-db-engine foo2zjs gtklp gutenprint hplip htmldoc ocrmypdf pdfarranger printrun poppler psutils ptouch-driver qpdf scribus splix system-config-printer unpaper simple-scan
fi

echo "Configure Vulkan/OpenGL tools? (yes/no)"
read _vulkan;

if [ "$_vulkan" = "yes" ]
then
    pkg_add vulkan-tools vulkan-loader vulkan-headers glfw glew gle freeglut
fi

echo "Configure Security/Pentesting tools? (yes/no)"
read _security;

if [ "$_security" = "yes" ]
then
    pkg_add pixiewps pgpdump pdfid pdfcrack pdf-parser osv-scanner lynis knockpy john john-jumbo isic ipguard integrit hydra gnutls fwbuilder fcrackzip exploitdb dsniff dirb cracklib clamav burpsuite amap aircrack-ng aide regripper reaver rdp rarcrack wpa_supplicant tls-attacker step-cli sqlmap pwntools
fi
