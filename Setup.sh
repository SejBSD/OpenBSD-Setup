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

echo "Configure GNOME? (yes/empty)"
read _confGnome;

if [ "$_confGnome" != "" ]
then
    pkg_add gnome gnome-tour gnome-initial-setup gnome-keyring gnome-menus gnome-screenshot gnome-session gnome-settings-daemon gnome-tweaks \
            gnome-usage gnome-control-center endeavor gdm nautilus gnome-power-manager sushi gnome-system-monitor gnome-terminal gnome-console \
            baobab

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

    echo "Configure GNOME Games? (yes/empty)"
    read _confGnomeGames;

    if [ "$_confGnomeGames" != "" ]
    then
        pkg_add aisleriot gnome-mahjongg quadrapassel
    fi

    echo "Configure GNOME Icons and Backgrounds? (yes/empty)"
    read _confGnomeIandB;

    if [ "$_confGnomeIandB" != "" ]
    then
        pkg_add adwaita-icon-theme gnome-backgrounds
    fi

    echo "Configure GNOME Shell + Extensions? (yes/empty)"
    read _confGnomeShell;

    if [ "$_confGnomeShell" != "" ]
    then
        pkg_add gnome-browser-connector gnome-shell gnome-shell-extensions
    fi

    echo "Configure GNOME Archive Utils? (yes/empty)"
    read _confGnomeArchive;

    if [ "$_confGnomeArchive" != "" ]
    then
        pkg_add gnome-autoar file-roller
    fi

    echo "Configure GNOME Desktop Utils? (yes/empty)"
    read _confGnomeDesktop;

    if [ "$_confGnomeDesktop" != "" ]
    then
        pkg_add gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-contacts dconf-editor gnome-desktop gnome-dictionary \
                gnome-font-viewer gedit gedit-plugins ghex gucharmap gnome-maps secrets totem totem-pl-parser tracker3 tracker3-miners \
                gnome-weather gnome-notes orca gnome-text-editor gnome-builder
    fi

    echo "Configure GNOME Multimedia? (yes/empty)"
    read _confGnomeMultimedia;

    if [ "$_confGnomeMultimedia" != "" ]
    then
        pkg_add cheese eog eog-plugins grilo grilo-plugins gnome-music gnome-photos gnome-video-effects
    fi

    echo "Configure GNOME Online Utils? (yes/empty)"
    read _confGnomeOnline;

    if [ "$_confGnomeOnline" != "" ]
    then
        pkg_add gnome-connections gnome-online-accounts polari vino gvfs
    fi

    echo "Configure GNOME Documentation? (yes/empty)"
    read _confGnomeDocs;

    if [ "$_confGnomeDocs" != "" ]
    then
        pkg_add gnome-devel-docs devhelp gnome-user-docs yelp yelp-tools yelp-xsl
    fi

    echo "Configure GNOME AT-SPI Utils? (yes/empty)"
    read _confGnomeAtSpi;

    if [ "$_confGnomeAtSpi" != "" ]
    then
        pkg_add accerciser at-spi2-core py-atspi
    fi

    echo "Configure GNOME Crypto Utils? (yes/empty)"
    read _confGnomeCrypto;

    if [ "$_confGnomeCrypto" != "" ]
    then
        pkg_add gcr gcr4 seahorse seahorse-nautilus 
    fi

    echo "Configure GNOME Gtk Frameworks (misc)? (yes/empty)"
    read _confGnomeGtk;

    if [ "$_confGnomeGtk" != "" ]
    then
        pkg_add amtk gnome-epub-thumbnailer gdl tepl
    fi

    echo "Configure GNOME Mutter (window and compositing manager based on Clutter)? (yes/empty)"
    read _confGnomeMutter;

    if [ "$_confGnomeMutter" != "" ]
    then
        pkg_add mutter
    fi

    echo "Configure GNOME gitg (graphical user interface for git)? (yes/empty)"
    read _confGnomeGitg;

    if [ "$_confGnomeGitg" != "" ]
    then
        pkg_add gitg
    fi

    echo "Configure GNOME gjs (Javascript bindings for GNOME)? (yes/empty)"
    read _confGnomeGjs;

    if [ "$_confGnomeGjs" != "" ]
    then
        pkg_add gjs
    fi

    echo "Configure GNOME gom (GObject to SQLite object mapper)? (yes/empty)"
    read _confGnomeGom;

    if [ "$_confGnomeGom" != "" ]
    then
        pkg_add gom
    fi
fi

echo "Configure XFCE? (yes/empty)"
read _confXfce;

if [ "$_confXfce" != "" ]
then
    pkg_add xfce xfce4

    sh ./Internal_InstallMultiple.sh xfce

    pkg_add exo garcon mousepad orage parole ristretto xfce4-terminal thunar thunar-archive thunar-media-tags thunar-vcs tumbler xfconf \
            xfdashboard xfdesktop xfmpc xfwm4 xfwm4-themes
fi

echo "Configure KDE? (yes/empty)"
read _confKde;

if [ "$_confKde" != "" ]
then
    pkg_add kde plasma-framework

    sh ./Internal_InstallMultiple.sh kf5

    pkg_add bluez-qt breeze-icons extra-cmake-modules frameworkintegration kactivities-stats kapidox karchive kauth kbookmarks kcalendarcore \
            kcmutils kcodecs kcompletion kconfig kconfigwidgets kcontacts kcoreaddons kcrash kdav kdbusaddons kdeclarative kded kdesignerplugin \
            kdesu kdewebkit kdnssd kdoctools kemoticons kfilemetadata kglobalaccel kguiaddons kholidays khtml ki18n kiconthemes kidletime \
            kimageformats kinit kio kitemmodels kitemviews kjobwidgets kmediaplayer knewstuff knotifications knotifyconfig kpackage kparts kpeople \
            kplotting kpty kquickcharts kross krunner kservice ktexteditor ktextwidgets kunitconversion kwayland kwidgetsaddons kwindowsystem kxmlgui \
            kxmlrpcclient oxygen-icons purpose solid sonnet syndication syntax-highlighting threadweaver

    pkg_add konqueror konsole korganizer kate grantleetheme ark knotes lokalize okular print-manager khelpcenter kget kcharselect kbackup kamera \
            filelight ark

    echo "Configure KDE Legacy Support (legacy support for kdelibs-4.x compatibility)? (yes/empty)"
    read _confKdeLegacy;

    if [ "$_confKdeLegacy" != "" ]
    then
        pkg_add kdelibs4support
    fi

    echo "Configure KDE kjs (JavaScript/ECMAScript engine for KDE and KDE framework for binding JavaScript object to QObjects)? (yes/empty)"
    read _confKdeKjs;

    if [ "$_confKdeKjs" != "" ]
    then
        pkg_add kjs kjsembed
    fi

    echo "Configure KDE Games? (yes/empty)"
    read _confKdeGames;

    if [ "$_confKdeGames" != "" ]
    then
        pkg_add konquest kreversi kshisen ksirk ksnakeduel kspaceduel ksquares ksudoku ktuberling kubrick palapeli picmi blinken bomber bovo granatier \
                kajongg kanagram kapman katomic kblackbox kblocks kbounce kbreakout kdiamond kfourinline kgoldrunner khangman kigo killbots kiriki \
                kjumpingcube klettres klickety klines kmahjongg kmines knavalbattle knetwalk kolf kollision lskat
    fi

    echo "Configure KDE Multimedia? (yes/empty)"
    read _confKdeMultimedia;

    if [ "$_confKdeMultimedia" != "" ]
    then
        pkg_add kolourpaint kontrast kruler spectacle svgpart kmix kmag kimagemapeditor kdenlive kcolorchooser juk gwenview elisa dragon
    fi

    echo "Configure KDE Learning? (yes/empty)"
    read _confKdeLearning;

    if [ "$_confKdeLearning" != "" ]
    then
        pkg_add ktouch kturtle minuet klettres kiten kgeography kdeedu-data kalzium cantor artikulate analitza kmplot
    fi
fi

echo "Configure MATE? (yes/empty)"
read _confMate;

if [ "$_confMate" != "" ]
then
    pkg_add mate
fi

echo "Configure LXQt? (yes/empty)"
read _confLxqt;

if [ "$_confLxqt" != "" ]
then
    pkg_add lxqt
fi

echo "Configure OpenBox? (yes/empty)"
read _confOpenBox;

if [ "$_confOpenBox" != "" ]
then
    pkg_add openbox
fi

echo "Configure i3? (yes/empty)"
read _confi3;

if [ "$_confi3" != "" ]
then
    pkg_add i3
fi

echo "Configure awesome? (yes/empty)"
read _confAwesome;

if [ "$_confAwesome" != "" ]
then
    pkg_add awesome
fi

echo "Configure bspwm? (yes/empty)"
read _confBspwm;

if [ "$_confBspwm" != "" ]
then
    pkg_add bspwm
fi

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                    Setting up Tools...                     ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Install AppManager - graphical interface for the OpenBSD package manager? (yes/empty)"
read _appManager;

if [ "$_appManager" != "" ]
then
    pkg_add appmanager
fi

echo "Install Web Browser (firefox/chromium/ungoogled-chromium/tor-browser)? (empty for chromium)"
read _webBrowser;

if [ "$_webBrowser" != "" ]
then
    pkg_add $_webBrowser
else
    pkg_add chromium
fi

echo "Install and configure neofetch (system information tool written in bash)? (yes/empty)"
read _neofetch;

if [ "$_neofetch" != "" ]
then
    pkg_add neofetch

    if [ "$_user" != "" ]
    then
        _shrcFilePath=/home/$_user/.kshrc

        echo "" >> $_shrcFilePath
        echo "# Added by OpenBSD-Setup script" >> $_shrcFilePath
        echo "neofetch" >> $_shrcFilePath
        echo "# End Added by OpenBSD-Setup script" >> $_shrcFilePath
    fi
fi

echo "Install flameshot (powerful yet simple to use screenshot software)? (yes/empty)"
read _flameshot;

if [ "$_flameshot" != "" ]
then
    pkg_add flameshot
fi

echo "Install VM tools (Virtual Machine Manager (virt-manager), QEMU, remotebox, virt-viewer, freerdp)? (yes/empty)"
read _virt;

if [ "$_virt" != "" ]
then
    pkg_add virt-manager qemu remotebox virt-viewer freerdp
fi

echo "Install Deluge (bittorrent client)? (yes/empty)"
read _deluge;

if [ "$_deluge" != "" ]
then
    pkg_add deluge
fi

echo "Install Cloud Tools (awscli, cloud-agent, google-cloud-sdk, packer)? (yes/empty)"
read _cloudTools;

if [ "$_cloudTools" != "" ]
then
    pkg_add awscli cloud-agent google-cloud-sdk packer
fi

echo "Install FUSE/FS (curlftpfs, dosfstools, e2fsprogs, exfat-fuse, mtools, ntfs-3g, squashfs-tools, sshfs-fuse, fuse-zip, encfs)? (yes/empty)"
read _fuse;

if [ "$_fuse" != "" ]
then
    pkg_add curlftpfs dosfstools e2fsprogs exfat-fuse mtools ntfs-3g squashfs-tools sshfs-fuse fuse-zip encfs
fi

echo "Install Converters (bchunk)? (yes/empty)"
read _conv;

if [ "$_conv" != "" ]
then
    pkg_add bchunk
fi

echo "Install Reverse Engineering Tools (rizin, binwalk, ghidra)? (yes/empty)"
read _revEng;

if [ "$_revEng" != "" ]
then
    pkg_add rizin binwalk ghidra
fi

echo "Install Containers? (yes/empty)"
read _containers;

if [ "$_containers" != "" ]
then
    pkg_add docker-cli kubectl oc serf terraform jailkit
fi

echo "Install PCB/Modeling-related tools (kicad, lepton-eda, librecad, oce, openscad, pcb2gcode, qcad)? (yes/empty)"
read _pcb;

if [ "$_pcb" != "" ]
then
    pkg_add kicad lepton-eda librecad oce openscad pcb2gcode qcad
fi

echo "Install productivity tools (kicad, projectlibre, impressive, gnucash, gnucash-docs)? (yes/empty)"
read _pcb;

if [ "$_pcb" != "" ]
then
    pkg_add kicad projectlibre impressive gnucash gnucash-docs
fi

echo "Install LibreOffice (multi-platform productivity suite)? (yes/empty)"
read _libreoffice;

if [ "$_libreoffice" != "" ]
then
    pkg_add libreoffice
fi

# inkscape

# vlc


# TODO: Finish - maybe add hexedit





# echo "Choose editor: zile, texworks, teaqt, qscintilla, poke, neovim-qt, libreoffice, leafpad, hexedit, hexcurse, focuswriter, featherpad, emacs, abiword - empty for none"
# read _editor;

# if [ "$_editor" != "" ]
# then
#     pkg_add $_editor
# fi

# echo "Install archive-related tools? (yes/empty)"
# read _archive;

# if [ "$_archive" != "" ]
# then
#     pkg_add zstd zip xz unzip unrar unarr unarj snappy sltar rzip quazip p7zip minizip lzop lz4 lzo2 lrzip deco bzip2 arc
# fi

# echo "Install multimedia-related tools? (yes/empty)"
# read _multimedia;

# if [ "$_multimedia" != "" ]
# then
#     pkg_add lmms shotcut vlc krita krita-gmic-plugin inkscape ffmpeg sk1 pixelorama gimp audacious opencv openbsd-backgrounds ocrad mypaint mypaint-brushes mypaint-brushes2 img2pdf ImageMagick GraphicsMagick gif2png flameshot darktable cadubi audacious-player ncspot lmms openal rhythmbox freealut flac audacity alac_decoder celt gsm libvorbis mac opencore-amr opus speex wavpack
# fi

# echo "Install printer tools? (yes/empty)"
# read _printer;

# if [ "$_printer" != "" ]
# then
#     pkg_add brlaser cups-pk-helper cups-bjnp cups cups-filters cups-pdf foomatic-db foomatic-db-engine foo2zjs gtklp gutenprint hplip htmldoc ocrmypdf pdfarranger printrun poppler psutils ptouch-driver qpdf scribus splix system-config-printer unpaper simple-scan
# fi

# echo "Install Vulkan/OpenGL tools? (yes/empty)"
# read _vulkan;

# if [ "$_vulkan" != "" ]
# then
#     pkg_add vulkan-tools vulkan-loader vulkan-headers glfw glew gle freeglut
# fi

# echo "Install Security/Pentesting tools? (yes/empty)"
# read _security;

# if [ "$_security" != "" ]
# then
#     pkg_add pixiewps pgpdump pdfid pdfcrack pdf-parser osv-scanner lynis knockpy john john-jumbo isic ipguard integrit hydra gnutls fwbuilder fcrackzip exploitdb dsniff dirb cracklib clamav burpsuite amap aircrack-ng aide regripper reaver rdp rarcrack wpa_supplicant tls-attacker step-cli sqlmap pwntools
# fi
