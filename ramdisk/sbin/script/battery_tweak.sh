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

LS=/sdcard/amazboost/LOGS/Battery_Tweaks.log

rm -f $LS
touch $LS

echo "# Amazboost LOGGING ENGINE" | busybox tee -a $LS
echo "" | busybox tee -a $LS
echo "$( date +"%m-%d-%Y %H:%M:%S" )  applying battery tweaks..." | busybox tee -a $LS;


setprop ro.mot.eri.losalert.delay 1000
setprop ro.ril.power_collapse 1
setprop pm.sleep_mode 1
setprop wifi.supplicant_scan_interval 180


echo "" | busybox tee -a $LS
echo "$( date +"%m-%d-%Y %H:%M:%S" ) battery tweaks applied successfully!" | busybox tee -a $LS;
