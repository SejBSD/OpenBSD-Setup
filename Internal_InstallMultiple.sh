#!/bin/sh

_foundPackages=$(pkg_info -a -Q $1 | sed 's/ (installed)//')

echo "Install? (yes/empty)"
read _install;

if [ "$_install" -ne "" ]
then
    pkg_add $_foundPackages
fi
