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

echo "Install core tools (nano, htop, neofetch, usbutils)? (yes/no): "
read _shouldInstallCoreTools;

if [ "$_shouldInstallCoreTools" = "yes" ]
then
    pkg_add nano htop neofetch usbutils

    if [ "$_user" != "" ]
    then
        _shrcFilePath=/home/$_user/.kshrc

        echo "" >> $_shrcFilePath
        echo "# Added by OpenBSD-Setup script" >> $_shrcFilePath
        echo "neofetch" >> $_shrcFilePath
        echo "# End Added by OpenBSD-Setup script" >> $_shrcFilePath
    fi
fi

echo "Install common tools (flameshot, dconf-editor, inkscape, Virtual Machine Manager (virt-manager), QEMU, remotebox)? (yes/no)"
read _shouldInstallCommonTools;

if [ "$_shouldInstallCommonTools" = "yes" ]
then
    pkg_add flameshot dconf-editor inkscape virt-manager qemu remotebox
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
    pkg_add awscli cloud-agent google-cloud-sdk
fi

echo "Configure FUSE/FS? (yes/no)"
read _fuse;

if [ "$_fuse" = "yes" ]
then
    pkg_add curlftpfs dosfstools e2fsprogs exfat-fuse mtools ntfs-3g squashfs-tools sshfs-fuse
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
    pkg_add rizin binwalk
fi

echo "Configure Containers? (yes/no)"
read _containers;

if [ "$_containers" = "yes" ]
then
    pkg_add docker-cli kubectl oc serf terraform
fi
