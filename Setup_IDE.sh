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
echo "## Choose language (python, java, rust, cpp, dotnet-mono, lua): "
read _language;

if [ "$_language" = "python" ]
then
  pkg_add pycharm py-pip python
fi

if [ "$_language" = "java" ]
then
  pkg_add intellij jdk
fi

if [ "$_language" = "rust" ]
then
  pkg_add rust
fi

if [ "$_language" = "cpp" ]
then
  pkg_add qtcreator qt5 qt6 cmake
fi
