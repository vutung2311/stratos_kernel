#!/system/bin/sh
#
# adapter hardware configuration from /proc/hardware/list
# bluetooth configuration
# bluetooth.port:ttyS1
# bluetooth.chip:bcm43438

bt_vendor_file=/system/etc/bluetooth/bt_vendor.conf
hardware_list=/proc/hardware/list

# create slpt notification pipe
/system/bin/busybox mount -o remount,rw /dev/block/platform/jzmmc_v1.2.0/by-name/data /data
rm -r /data/slpt
mkdir /data/slpt
chmod 777 /data/slpt
busybox mkfifo -m 777 /data/slpt/slpt_transport_fifo
busybox mkfifo -m 777 /data/slpt/slpt_pipe_s2l_fifo

if [ ! -f "$bt_vendor_file" ]; then

bt_firmware_patch=/system/etc/firmware
bt_firmware_file_path=/system/etc/firmware/bcm43438
dst_file_path=/etc/firmware/bcm

dst_port=`/system/bin/busybox cat $hardware_list | /system/bin/busybox grep "bluetooth" | /system/bin/busybox grep "port" | /system/bin/busybox awk -F ':' '{print $NF}' `
dst_chip=`/system/bin/busybox cat $hardware_list | /system/bin/busybox grep "bluetooth" | /system/bin/busybox grep "chip" | /system/bin/busybox awk -F ':' '{print $NF}' `

/system/bin/busybox mount -o remount,rw /dev/block/platform/jzmmc_v1.2.0/by-name/system /system

if [ "$dst_chip" != "" ]; then
    /system/bin/busybox rm -f $dst_file_path
    /system/bin/ln -s $bt_firmware_patch/$dst_chip ${dst_file_path}
fi

echo -e \
    "# UART device port where Bluetooth controller is attached\n"\
    "UartPort = /dev/$dst_port\n"\
    "\n"\
    "# Firmware patch file location\n"\
    "FwPatchFilePath = $bt_firmware_file_path/\n"\
    "FwPatchFileName = BCM43430A1.hcd\n"\
    > $bt_vendor_file

chmod 0644 $bt_vendor_file

/system/bin/busybox mount -o remount,ro /dev/block/platform/jzmmc_v1.2.0/by-name/system /system

fi
