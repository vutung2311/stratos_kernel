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

LS=/sdcard/amazboost/LOGS/Cleaner_Tweaks.log

rm -f $LS
touch $LS

echo "# Amazboost LOGGING ENGINE" | busybox tee -a $LS
echo "" | busybox tee -a $LS
echo "$( date +"%m-%d-%Y %H:%M:%S" )  applying performance tweaks..." | busybox tee -a $LS;

# General performance tweaks

setprop sys.dalvik-hyperthreading true
setprop persist.sys.dalvik.hyperthreading true
setprop persist.android.strictmode 0

# Disabling logs and debugging for smoother experience

busybox stop logd
sysctl -w vm.panic_on_oom=0
sysctl -w kernel.panic_on_oops=0
sysctl -w kernel.panic=0

echo "" | busybox tee -a $LS
echo "$( date +"%m-%d-%Y %H:%M:%S" ) perfomance tweaks applied successfully!" | busybox tee -a $LS;