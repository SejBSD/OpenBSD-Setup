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
    pkg_add qt6 qt6-qt3d qt6-qt5compat qt6-qtcharts qt6-qtconnectivity qt6-qtdatavis3d qt6-qtimageformats qt6-qtlottie qt6-qtmultimedia \
            qt6-qtnetworkauth qt6-qtpositioning qt6-qtquick3d qt6-qtquicktimeline qt6-qtremoteobjects qt6-qtscxml qt6-qtsensors qt6-qtserialbus \
            qt6-qtserialport qt6-qtshadertools qt6-qtsvg qt6-qttools qt6-qttranslations qt6-qtvirtualkeyboard qt6-qtwayland
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

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                  Setting up .NET (Mono)...                 ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Configure .NET (Mono)? (yes/empty)"
read _net;

if [ "$_net" != "" ]
then
  pkg_add nuget msbuild mono mono-addins dnspy mono-gtk2
fi

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                      Setting up Lua...                     ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Configure Lua? (yes/empty)"
read _lua;

if [ "$_lua" != "" ]
then
  pkg_add lua
fi

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                      Setting up Asm...                     ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Configure Asm? (yes/empty)"
read _asm;

if [ "$_asm" != "" ]
then
  pkg_add yasm ald wabt binaryen distorm3
fi

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                      Setting up Web...                     ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Configure Web? (yes/empty)"
read _web;

if [ "$_web" != "" ]
then
  pkg_add yarn node sass

  echo "Choose IDE (bluefish)"
  read _ide;
  
  if [ "$_ide" != "" ]
  then
    pkg_add $_ide
  fi

  # TODO: Try configure npm
fi

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                      Setting up AVR...                     ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Configure AVR? (yes/empty)"
read _avr;

if [ "$_avr" != "" ]
then
  pkg_add avr avrdude simulavr 
fi

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                    Setting up GameBoy...                   ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Configure GameBoy? (yes/empty)"
read _gb;

if [ "$_gb" != "" ]
then
  pkg_add rgbds
fi

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                     Setting up SDL2...                     ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Configure SDL2? (yes/empty)"
read _sdl2;

if [ "$_sdl2" != "" ]
then
  pkg_add sdl2 sdl2-ttf sdl2-net sdl2-mixer sdl2-image sdl2-gfx
fi

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                      Setting up SDL...                     ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Configure SDL1? (yes/empty)"
read _sdl;

if [ "$_sdl" != "" ]
then
  pkg_add sdl sdl-ttf sdl-sound sdl-pango sdl-net sdl-mixer sdl-image sdl-gfx
fi

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                    Setting up Prolog...                    ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Configure Prolog? (yes/empty)"
read _prolog;

if [ "$_prolog" != "" ]
then
  pkg_add swi-prolog gprolog
fi

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                     Setting up BASIC...                    ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Configure BASIC? (yes/empty)"
read _basic;

if [ "$_basic" != "" ]
then
  pkg_add freebasic
fi

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                     Setting up COBOL...                    ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Configure COBOL? (yes/empty)"
read _cobol;

if [ "$_cobol" != "" ]
then
  pkg_add gnucobol
fi

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                      Setting up Go...                      ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Configure Go? (yes/empty)"
read _go;

if [ "$_go" != "" ]
then
  pkg_add go
fi

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                     Setting up Scala...                    ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Configure Scala? (yes/empty)"
read _scala;

if [ "$_scala" != "" ]
then
  pkg_add scala
  
  echo "Choose IDE (intellij): (empty for none)"
  read _ide;

  if [ "$_ide" != "" ]
  then
    pkg_add $_ide
  fi
fi

# TODO: Add Perl - pkg_add parrot
