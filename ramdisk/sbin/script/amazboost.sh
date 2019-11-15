#!/system/bin/sh

mkdir -p /sdcard/amazboost/LOGS
/system/bin/sh /sbin/script/battery_tweak.sh
/system/bin/sh /sbin/script/cleaner_tweak.sh
/system/bin/sh /sbin/script/csz_tweak.sh
/system/bin/sh /sbin/script/ext4_tweak.sh
/system/bin/sh /sbin/script/io_tweak.sh
/system/bin/sh /sbin/script/kernel_tweak.sh
/system/bin/sh /sbin/script/logcat_tweak.sh
/system/bin/sh /sbin/script/performance_tweak.sh
/system/bin/sh /sbin/script/ram_tweak.sh
/system/bin/sh /sbin/script/renice_tweak.sh
/system/bin/sh /sbin/script/vm_tweak.sh
