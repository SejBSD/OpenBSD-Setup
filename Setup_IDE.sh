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
echo "## Choose language (shell, python, java, rust, cpp, dotnet-mono, lua, asm, web, avr, gameboy, prolog, basic, cobol, go, scala):"
read _language;

pkg_add git-lfs git-cvs git-sync

if [ "$_language" = "shell" ]
then
  echo ""
  echo "################################################################"
  echo "##                                                            ##"
  echo "##                     Setting up Shell...                    ##"
  echo "##                                                            ##"
  echo "################################################################"
  echo ""

  pkg_add autoconf automake
fi

if [ "$_language" = "python" ]
then
  echo ""
  echo "################################################################"
  echo "##                                                            ##"
  echo "##                    Setting up Python...                    ##"
  echo "##                                                            ##"
  echo "################################################################"
  echo ""
  
  # TODO: Add common libs + tools

  pkg_add pycharm py-pip python bpython py-test py-virtualenv parrot
fi

if [ "$_language" = "java" ]
then
  echo ""
  echo "################################################################"
  echo "##                                                            ##"
  echo "##                     Setting up Java...                     ##"
  echo "##                                                            ##"
  echo "################################################################"
  echo ""

  pkg_add jdk jd-gui meson maven gradle jna
  
  echo "Choose IDE (intellij, netbeans):"
  read _ide;
  
  pkg_add $_ide
  
  echo "Install Android tools? (yes/no)"
  read _android;
  
  if [ "$_android" = "yes" ]
  then
    pkg_add jadx adb apktool
  fi
fi

if [ "$_language" = "rust" ]
then
  echo ""
  echo "################################################################"
  echo "##                                                            ##"
  echo "##                     Setting up Rust...                     ##"
  echo "##                                                            ##"
  echo "################################################################"
  echo ""

  pkg_add rust meson
fi

if [ "$_language" = "cpp" ]
then
  echo ""
  echo "################################################################"
  echo "##                                                            ##"
  echo "##                     Setting up C/C++...                    ##"
  echo "##                                                            ##"
  echo "################################################################"
  echo ""

  pkg_add qt5 qt6 cmake ninja meson llvm samurai

  # TODO: Add Qt5 and Qt6 packages with yes/no
  
  echo "Install GCC? (yes/no)"
  read _installGcc;
  
  if [ "$_installGcc" = "yes" ]
  then
    pkg_add gcc gdb
  fi
  
  echo "Install TinyCC? (yes/no)"
  read _tinycc;
  
  if [ "$_tinycc" = "yes" ]
  then
    pkg_add tcc
  fi
  
  echo "Choose IDE (qt-creator, codeblocks, kdevelop)"
  read _cppIde;
  
  pkg_add $_cppIde
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
