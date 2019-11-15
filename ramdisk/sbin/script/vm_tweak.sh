#!/system/bin/sh
#=====================================================
#=====================================================
#========== AmazBoost by androidexpert35 =============
#=====================================================
#=====================================================
#======== Copyright (C) 2018 Antonio Cirielli ========
#=======================================================================#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.
#=======================================================================#

LS=/sdcard/amazboost/LOGS/Vm_Tweaks.log

rm -f $LS
touch $LS

echo "# Amazboost LOGGING ENGINE" | busybox tee -a $LS
echo "" | busybox tee -a $LS
echo "$( date +"%m-%d-%Y %H:%M:%S" )  applying sysctl tweaks..." | busybox tee -a $LS;


RAM=$((`awk '/MemTotal/{print $2}' /proc/meminfo`/1024))
fs=$(($RAM/4*256))

busybox chmod 644 /proc/sys/*;
busybox sysctl -e -w vm.drop_caches=3
busybox sysctl -e -w vm.min_free_kbytes=4096
busybox sysctl -e -w vm.oom_kill_allocating_task=1
busybox sysctl -e -w vm.dirty_background_ratio=15
busybox sysctl -e -w vm.dirty_ratio=30
busybox sysctl -e -w vm.vfs_cache_pressure=20
busybox sysctl -e -w vm.overcommit_memory=1
busybox sysctl -e -w vm.overcommit_ratio=70
busybox sysctl -e -w vm.min_free_order_shift=3
busybox sysctl -e -w vm.laptop_mode=0
busybox sysctl -e -w vm.block_dump=0
busybox sysctl -e -w vm.oom_dump_tasks=1
busybox sysctl -e -w vm.swappiness=0
busybox sysctl -e -w vm.page-cluster=0
busybox sysctl -e -w vm.dirty_expire_centisecs=200
busybox sysctl -e -w vm.dirty_writeback_centisecs=500
busybox sysctl -e -w vm.panic_on_oom=0
busybox sysctl -e -w vm.drop_caches=1
busybox sysctl -e -w fs.lease-break-time=10
busybox sysctl -e -w fs.inotify.max_queued_events=32000
busybox sysctl -e -w fs.inotify.max_user_instances=256
busybox sysctl -e -w fs.inotify.max_user_watches=10240
busybox sysctl -e -w fs.file-max=$fs


busybox sleep 1


echo "VM Tweaks have been applied successfully, enjoy!!"


echo "" | busybox tee -a $LS
echo "$( date +"%m-%d-%Y %H:%M:%S" ) sysctl tweaks applied successfully!" | busybox tee -a $LS;
