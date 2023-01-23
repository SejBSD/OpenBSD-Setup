#!/bin/sh

echo ""
echo "################################################################"
echo "##                                                            ##"
echo "##                    Setting up Docker...                    ##"
echo "##                                                            ##"
echo "################################################################"
echo ""

_isoName=alpine-virt-3.16.3-x86_64.iso
_alpineIsoUrl=https://dl-cdn.alpinelinux.org/alpine/v3.16/releases/x86_64/$_isoName
_destinationDir=Setup_DockerVM
_vmSize=64G
_vmName=docker
_etcVmConf=/etc/vm.conf

rcctl enable vmd
rcctl start vmd

cd /opt
mkdir $_destinationDir
cd $_destinationDir

ftp $_alpineIsoUrl

vmctl create -s $_vmSize $_vmName.qcow2

echo `
switch \"uplink\" {
    interface bridge0
}

vm \"${$_vmName}\" {
    disable

    memory 2G

    cdrom \"/opt/${$_destinationDir}/${$_isoName}\"
    disk \"/opt/${$_destinationDir}/${$_vmName}.qcow2\"

    interface {
        switch \"uplink\"
        locked lladdr fe:e1:ba:d2:02:30
    }
}` >> $_etcVmConf

rcctl restart vmd

vmctl start -c -B cdrom $_vmName

# Send keys to console to login to Alpine
stdin < "root"

setup-alpine

# Power off Alpine
poweroff

# TODO: Connect to VM using SSH

apk update
apk add docker

addgroup myself docker

rc-service docker status

rc-update add docker

rc-service docker start

docker run hello-world