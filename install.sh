#!/bin/bash

script_path=$(realpath $0)
script_dir=$(dirname $script_path)

if [ -f /etc/libvirt/hooks/qemu -o -d /etc/libvirt/hooks/qemu.d ]; then
    echo 'Error: /etc/libvirt/hooks exists.'
    exit 1
fi

if [ -f /etc/systemd/system/libvirt-nosleep@.service ]; then
    echo 'Error: /etc/systemd/system/libvirt-nosleep@.service exists.'
    exit 1
fi

if [ ! -d /usr/share/vgabios/ ]; then
    mkdir -p /usr/share/vgabios/
fi

mkdir -p /etc/libvirt/hooks
cp -r $script_dir/libvirt-hooks/qemu /etc/libvirt/hooks/qemu
cp -r $script_dir/libvirt-hooks/qemu.d /etc/libvirt/hooks/qemu.d
cp -r $script_dir/libvirt-nosleep@.service /etc/systemd/system/libvirt-nosleep@.service 
mkdir -p /usr/share/vgabios/
cp -r $script_dir/rom/Gigabyte.RTX3090.24576.210315_3.rom /usr/share/vgabios/Gigabyte.RTX3090.24576.210315_3.rom
systemctl restart libvirtd

