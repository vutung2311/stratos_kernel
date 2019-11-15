#!/system/bin/sh

#mount -o remount,rw /system

if [ ! -d /data/misc/sn ]; then
mkdir /data/misc/sn
fi

rm -rf /data/misc/sn/serial_numbers
touch /data/misc/sn/serial_numbers
rm -rf /data/misc/sn/serial_numbers_factory
touch /data/misc/sn/serial_numbers_factory
# See partition distribution from
# <bootable/bootloader/uboot/board/ingenic/watch/partitions.tab>
dd  if=/dev/block/platform/jzmmc_v1.2.0/by-name/misc  of=/data/misc/sn/serial_numbers bs=512 count=1 skip=3
dd  if=/dev/block/platform/jzmmc_v1.2.0/by-name/misc  of=/data/misc/sn/serial_numbers_factory bs=512 count=1 skip=6

#mount -o remount,ro /system

