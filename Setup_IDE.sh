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
read "## Choose language (java, rust, cpp, python, dotnet-mono, lua): " _language;
