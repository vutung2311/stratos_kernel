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
#======================================================================#

LS=/sdcard/amazboost/LOGS/kernel_Tweaks.log

rm -f $LS
touch $LS

echo "# AmazBoost LOGGING ENGINE" | busybox tee -a $LS
echo "" | busybox tee -a $LS
echo "$( date +"%m-%d-%Y %H:%M:%S" )  applying kernel tweaks..." | busybox tee -a $LS;


if [ -e /proc/sys/kernel/softlockup_panic ]
then
 echo 0 > /proc/sys/kernel/softlockup_panic
fi
if [ -e /proc/sys/kernel/hung_task_timeout_secs ]
then
 echo 0 > /proc/sys/kernel/hung_task_timeout_secs
fi
if [ -e /proc/sys/kernel/panic_on_oops ]
then
 echo 0 > /proc/sys/kernel/panic_on_oops
fi
if [ -e /proc/sys/kernel/panic ]
then
 echo 0 > /proc/sys/kernel/panic
fi

busybox sysctl -e -w kernel.threads_max=525810
busybox sysctl -e -w kernel.sem="500 5120000 64 2048"
busybox sysctl -e -w kernel.msgmax=64000
busybox sysctl -e -w kernel.shmmax=268435456
busybox sysctl -e -w kernel.shmmni=1024
busybox sysctl -e -w kernel.shmall=262144
busybox sysctl -e -w kernel.msgmni=2048
busybox sysctl -e -w kernel.nmi_watchdog=0
busybox sysctl -e -w kernel.random.read_wakeup_threshold=1366
busybox sysctl -e -w kernel.random.write_wakeup_threshold=2048

echo "NO_NEW_FAIR_SLEEPERS" > /sys/kernel/debug/sched_features
echo "NO_NORMALIZED_SLEEPER" > /sys/kernel/debug/sched_features


echo "Kernel Tweaks have been applied successfully, enjoy!!"

echo "" | busybox tee -a $LS
echo "$( date +"%m-%d-%Y %H:%M:%S" ) Kernel tweaks applied successfully!" | busybox tee -a $LS;
