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
echo "## Choose language (shell, python, java, rust, cpp, dotnet-mono, lua, asm, web):"
read _language;

pkg_add git-lfs git-cvs

if [ "$_language" = "shell" ]
then
  pkg_add autoconf automake
fi

if [ "$_language" = "python" ]
then
  pkg_add pycharm py-pip python bpython
fi

if [ "$_language" = "java" ]
then
  pkg_add jdk jd-gui meson maven
  
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
  pkg_add qt5 qt6 cmake ninja meson llvm
  
  echo "Install GCC? (yes/no)"
  read _installGcc;
  
  if [ "$_installGcc" = "yes" ]
  then
    pkg_add gcc gdb
  fi
  
  echo "Choose IDE (qtcreator, codeblocks)"
  read _cppIde;
  
  pkg_add $_cppIde
fi

if [ "$_language" = "dotnet-mono" ]
then
  pkg_add nuget msbuild mono-addins mono dnspy
fi

if [ "$_language" = "lua" ]
then
  pkg_add lua
fi

if [ "$_language" = "asm" ]
then
  pkg_add yasm ald
fi

if [ "$_language" = "web" ]
then
  pkg_add yarn node 
fi
