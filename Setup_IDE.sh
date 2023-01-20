#!/bin/sh

pkg_add -u

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##            Setting up Development Environment...           ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

# read -p "Choose IDE (pycharm, qt-creator, kdevelop, emacs)" _ide;

# pkg_add $_ide

echo ""
echo "## Choose language (shell, python, java, rust, cpp, dotnet-mono, lua, asm):"
read _language;

if [ "$_language" = "shell" ]
then
  pkg_add autoconf automake
fi

if [ "$_language" = "python" ]
then
  pkg_add pycharm py-pip python
fi

if [ "$_language" = "java" ]
then
  pkg_add intellij jdk jd-gui meson maven
  
  echo "Choose IDE (intellij, netbeans):"
  read _ide;
  
  pkg_add $_ide
fi

if [ "$_language" = "rust" ]
then
  pkg_add rust meson
fi

if [ "$_language" = "cpp" ]
then
  pkg_add qtcreator qt5 qt6 cmake ninja meson llvm
fi

if [ "$_language" = "dotnet-mono" ]
then
  pkg_add nuget msbuild mono-addins mono
fi

if [ "$_language" = "lua" ]
then
  pkg_add lua
fi

if [ "$_language" = "asm" ]
then
  pkg_add nasm 
fi
