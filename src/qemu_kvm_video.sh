#!/bin/bash

#sudo QEMU_AUDIO_DRV=pa apulse qemu-system-x86_64 \
#	-nodefaults \
#	-nodefconfig \
#	-nographic \
#	-serial none \
#	-parallel none \
#	-name Windows10 \
#	-machine q35,accel=kvm \
#	-enable-kvm \
#	-cpu host,kvm=off,check \
#	-smp cpus=4,sockets=1,cores=4,threads=1 \
#	-m 8G \
#	-balloon virtio \
#	-rtc base=localtime,clock=host \
#	-drive if=pflash,format=raw,readonly,file=~/qemu/ovmf64/OVMF-pure-efi.fd \
#	-drive if=pflash,format=raw,file=~/qemu/ovmf64/OVMF_VARS-pure-efi.fd \
#	-soundhw hda \
#	-net nic,vlan=0,model=virtio -net tap,vlan=0,ifname=tap0,script=no,downscript=no \
#	-vga none \
#	-device vfio-pci,host=01:00.0,multifunction=on \
#	-device vfio-pci,host=01:00.1 \
#	-device vfio-pci,host=00:1d.0 \
#	-drive file=~/qemu/data/win10.img,if=virtio,format=raw,index=0,media=disk,cache=none,aio=native \
#	-boot order=c \
#	-monitor stdio \
#	"$@"
#
##!/bin/bash
#
#QEMU="/usr/bin/qemu-system-x86_64"
#
#NIC="virtio"
#
#gen_macaddr() {
#    printf 'DE:AD:%02X:%02X:%02X:%02X\n' $((RANDOM%256)) $(($$%256)) $(($$/256%256)) $(($1))
#}
#
#MACADDR0=$(gen_macaddr 10)
#echo "macaddr0: ${MACADDR0}"
#
#${QEMU} \
#    -enable-kvm \
#    -m 5120 \
#    -machine pc-i440fx-2.0,accel=kvm \
#    -cpu host,hv_relaxed,hv_vapic,hv_spinlocks=0x1000 \
#    -smp 4,sockets=1,cores=4,threads=1 \
#    -realtime mlock=off -rtc base=localtime \
#    -boot menu=off,strict=on -vga none -nographic \
#    -drive if=pflash,format=raw,readonly,file=/mnt/vm/OVMF/OVMF_CODE.fd \
#    -drive if=pflash,format=raw,file=/mnt/vm/OVMF/OVMF_VARS.fd \
#    -device virtio-scsi-pci,id=scsi \
#    -drive file=/dev/sdb,media=disk,if=virtio,id=c,format=raw,cache=none,aio=native \
#    -net nic,vlan=0,macaddr=de:ad:b2:bf:78:0a,model=virtio -net bridge,vlan=0 \
#    -device pci-assign,host=01:00.0 \
#    -device pci-assign,host=01:00.1 \
#    -device nec-usb-xhci,id=usb,bus=pci.0,addr=0x1.0x2 \
#    -device usb-host,hostbus=1,hostport=1 \
#    -device usb-host,hostbus=1,hostport=2 \
#
#//
#

echo "1002 6660" > /sys/bus/pci/drivers/pci-stub/new_id
echo "0000:01:00.0" > /sys/bus/pci/devices/0000\:01\:00.0/driver/unbind
echo "0000:01:00.0" > /sys/bus/pci/drivers/pci-stub/bind


#//

