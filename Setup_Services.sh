#!/bin/sh

pkg_add -u

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                   Setting up Services...                   ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                  Setting up phpMyAdmin...                  ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

echo "Configure phpMyAdmin? (yes/empty)"
read _phpMyAdmin;

if [ "$_phpMyAdmin" -ne "" ]
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

echo "Configure NGINX? (yes/empty)"
read _nginx;

if [ "$_nginx" -ne "" ]
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

echo "Configure Apache HTTP Server? (yes/empty)"
read _apacheHttp;

if [ "$_apacheHttp" -ne "" ]
then
  pkg_add apache-httpd
fi
