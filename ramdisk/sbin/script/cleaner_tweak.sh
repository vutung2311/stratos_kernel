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
echo "$( date +"%m-%d-%Y %H:%M:%S" )  Cleaning device..." | busybox tee -a $LS;

# Clean cache and logs every boot
rm -f /cache/*.apk;
rm -f /cache/*.tmp;
rm -f /cache/recovery/*;
rm -f /data/*.log;
rm -f /data/*.txt;
rm -f /data/log/*.*;
rm -f /data/local/*.log;
rm -f /data/local/tmp/*.*;
rm -f /data/last_alog/*;
rm -f /data/last_kmsg/*;
rm -rf /data/tombstones/*;
rm -f /data/system/dropbox/*;
rm -f /data/system/usagestats/*.*;
rm -rf /sdcard/LOST.DIR;

echo "" | busybox tee -a $LS
echo "$( date +"%m-%d-%Y %H:%M:%S" ) device cleaned successfully!" | busybox tee -a $LS;