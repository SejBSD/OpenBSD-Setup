#!/bin/sh

pkg_add -u

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##            Setting up Development Environment...           ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                      Setting up Git...                     ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Configure Git? (yes/empty)"
read _git;

if [ "$_git" != "" ]
then
  pkg_add git-lfs git-cvs git-sync
fi

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                     Setting up Shell...                    ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Configure Shell? (yes/empty)"
read _shell;

if [ "$_shell" != "" ]
then
  pkg_add autoconf automake
fi

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                    Setting up Python...                    ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Configure Python? (yes/empty)"
read _python;

if [ "$_python" != "" ]
then
  pkg_add py-pip python bpython py-test py-virtualenv parrot jupyter-notebook

  echo "Choose IDE (pycharm): (empty for none)"
  read _ide;

  if [ "$_ide" != "" ]
  then
    pkg_add $_ide
  fi
fi

# TODO: Add common Python libs + tools

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                     Setting up Java...                     ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Configure Java? (yes/empty)"
read _java;

if [ "$_java" != "" ]
then
  pkg_add jdk jd-gui meson maven gradle jna tomcat

  echo "Choose IDE (intellij, netbeans): (empty for none)"
  read _ide;

  if [ "$_ide" != "" ]
  then
    pkg_add $_ide
  fi
  
  echo "Install Android tools? (yes/no)"
  read _android;
  
  if [ "$_android" = "yes" ]
  then
    pkg_add jadx adb apktool
  fi
fi

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                     Setting up Rust...                     ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Configure Rust? (yes/empty)"
read _rust;

if [ "$_rust" != "" ]
then
  pkg_add rust meson
fi

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                     Setting up C/C++...                    ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Configure C/C++? (yes/empty)"
read _cpp;

if [ "$_cpp" != "" ]
then
  pkg_add cmake ninja meson llvm samurai

  echo "Configure Qt6? (yes/empty)"
  read _qt6;
  
  if [ "$_qt6" != "" ]
  then
    pkg_add qt6 # TODO: Add all Qt6 packages
  fi

  echo "Configure Qt5? (yes/empty)"
  read _qt5;
  
  if [ "$_qt5" != "" ]
  then
    pkg_add qt5 # TODO: Add all Qt5 packages
  fi
  
  echo "Configure GCC? (yes/empty)"
  read _gcc;
  
  if [ "$_gcc" != "" ]
  then
    pkg_add gcc gdb
  fi
  
  echo "Configure TinyCC? (yes/empty)"
  read _tinycc;
  
  if [ "$_tinycc" != "" ]
  then
    pkg_add tcc
  fi
  
  echo "Choose IDE (qt-creator, codeblocks, kdevelop): (empty for none)"
  read _ide;

  if [ "$_ide" != "" ]
  then
    pkg_add $_ide
  fi
fi

if [ "$_language" = "dotnet-mono" ]
then
  echo ""
  echo "################################################################"
  echo "##                                                            ##"
  echo "##                  Setting up .NET (Mono)...                 ##"
  echo "##                                                            ##"
  echo "################################################################"
  echo ""

  pkg_add nuget msbuild mono-addins mono dnspy mono-gtk2
fi

if [ "$_language" = "lua" ]
then
  echo ""
  echo "################################################################"
  echo "##                                                            ##"
  echo "##                      Setting up Lua...                     ##"
  echo "##                                                            ##"
  echo "################################################################"
  echo ""

  pkg_add lua
fi

if [ "$_language" = "asm" ]
then
  echo ""
  echo "################################################################"
  echo "##                                                            ##"
  echo "##                      Setting up Asm...                     ##"
  echo "##                                                            ##"
  echo "################################################################"
  echo ""

  pkg_add yasm ald wabt binaryen distorm3
fi

if [ "$_language" = "web" ]
then
  echo ""
  echo "################################################################"
  echo "##                                                            ##"
  echo "##                      Setting up Web...                     ##"
  echo "##                                                            ##"
  echo "################################################################"
  echo ""

  pkg_add yarn node sass

  echo "Choose IDE (bluefish)"
  read _ide;
  
  pkg_add $_ide
fi

if [ "$_language" = "avr" ]
then
  echo ""
  echo "################################################################"
  echo "##                                                            ##"
  echo "##                      Setting up AVR...                     ##"
  echo "##                                                            ##"
  echo "################################################################"
  echo ""

  pkg_add avrdude simulavr 
fi

if [ "$_language" = "gameboy" ]
then
  echo ""
  echo "################################################################"
  echo "##                                                            ##"
  echo "##                    Setting up GameBoy...                   ##"
  echo "##                                                            ##"
  echo "################################################################"
  echo ""

  pkg_add rgbds
fi

echo "Install SDL2? (yes/no)"
read _installSdlTwo;

if [ "$_installSdlTwo" = "yes" ]
then
  echo ""
  echo "################################################################"
  echo "##                                                            ##"
  echo "##                     Setting up SDL2...                     ##"
  echo "##                                                            ##"
  echo "################################################################"
  echo ""

  pkg_add sdl2 sdl2-ttf sdl2-net sdl2-mixer sdl2-image sdl2-gfx
fi

echo "Install SDL1? (yes/no)"
read _installSdlOne;

if [ "$_installSdlOne" = "yes" ]
then
  echo ""
  echo "################################################################"
  echo "##                                                            ##"
  echo "##                      Setting up SDL...                     ##"
  echo "##                                                            ##"
  echo "################################################################"
  echo ""

  pkg_add sdl sdl-ttf sdl-sound sdl-pango sdl-net sdl-mixer sdl-image sdl-gfx
fi

if [ "$_language" = "prolog" ]
then
  echo ""
  echo "################################################################"
  echo "##                                                            ##"
  echo "##                    Setting up Prolog...                    ##"
  echo "##                                                            ##"
  echo "################################################################"
  echo ""

  pkg_add swi-prolog gprolog
fi

if [ "$_language" = "basic" ]
then
  echo ""
  echo "################################################################"
  echo "##                                                            ##"
  echo "##                     Setting up BASIC...                    ##"
  echo "##                                                            ##"
  echo "################################################################"
  echo ""

  pkg_add freebasic
fi

if [ "$_language" = "cobol" ]
then
  echo ""
  echo "################################################################"
  echo "##                                                            ##"
  echo "##                     Setting up COBOL...                    ##"
  echo "##                                                            ##"
  echo "################################################################"
  echo ""

  pkg_add gnucobol
fi

if [ "$_language" = "go" ]
then
  echo ""
  echo "################################################################"
  echo "##                                                            ##"
  echo "##                      Setting up Go...                      ##"
  echo "##                                                            ##"
  echo "################################################################"
  echo ""

  pkg_add go
fi

if [ "$_language" = "scala" ]
then
  echo ""
  echo "################################################################"
  echo "##                                                            ##"
  echo "##                     Setting up Scala...                    ##"
  echo "##                                                            ##"
  echo "################################################################"
  echo ""

  pkg_add scala
fi

# TODO: Add Perl - pkg_add parrot

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                  Setting up phpMyAdmin...                  ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Configure phpMyAdmin? (yes/no)"
read _phpMyAdmin;

if [ "$_phpMyAdmin" = "yes" ]
then
  pkg_add phpmyadmin
fi

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                     Setting up NGINX...                    ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Configure NGINX? (yes/no)"
read _nginx;

if [ "$_nginx" = "yes" ]
then
  pkg_add nginx
fi

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##              Setting up Apache HTTP Server...              ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Configure Apache HTTP Server? (yes/no)"
read _apacheHttp;

if [ "$_apacheHttp" = "yes" ]
then
  pkg_add apache-httpd
fi
