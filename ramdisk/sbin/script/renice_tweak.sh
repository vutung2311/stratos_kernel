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

LS=/sdcard/amazboost/LOGS/renice.log

if [ -e $LS ]; then
busybox	rm $LS;
fi

busybox touch $LS;
busybox echo "# AmazBoost Engine" | busybox tee -a $LS;
busybox echo "" | busybox tee -a $LS;
busybox echo "# STARTING AmazBoost : $( date +"%m-%d-%Y %H:%M:%S" )" | busybox tee -a $LS;
busybox echo "" | busybox tee -a $LS;


for pid in `busybox ps | busybox awk '{ if ( $2 ~ /^root$/ && $4 !~ /netd$|rild$|zygote$|kswapd|vold|loop/ ) print $1 }'`; do
busybox ionice -c 2 -n 3 -p $pid 2>/dev/null
done;

busybox echo "Renice Swap/Loop... = Activated..." | busybox tee -a $LS;

for pid in $(busybox pgrep pdflush 2>/dev/null); do
busybox renice 7 $pid 2>/dev/null
busybox ionice -c 3 -n 7 -p $pid 2>/dev/null
done;

busybox echo "Renice PdFlush... = Activated..." | busybox tee -a $LS;

for pid in $(busybox pgrep flush- 2>/dev/null); do
busybox renice 7 $pid 2>/dev/null
busybox ionice -c 3 -n 7 -p $pid 2>/dev/null
done;

busybox echo "Renice Flush... = Activated..." | busybox tee -a $LS;


pid=$(busybox pgrep zygote 2>/dev/null)
busybox renice -1 $pid 2>/dev/null
busybox ionice -c 1 -n 0 -p $pid 2>/dev/null

busybox echo "Renice Zygote... = Activated..." | busybox tee -a $LS;

for pid in `dumpsys activity services | busybox grep -i app=ProcessRecord | busybox awk '{ print $2 }' | busybox grep -v '/100[0-9]}' | busybox cut -d: -f1`; do
busybox renice 7 $pid 2>/dev/null
busybox ionice -c 2 -n 7 -p $pid 2>/dev/null
done;

busybox echo "Renice Dumpsys Activity Service = Activated..." | busybox tee -a $LS;

for pid in `busybox ps | busybox awk '{ if ( $2 ~ /^app_/) print $1 }'`; do
busybox renice -1 $pid 2>/dev/null
busybox ionice -c 1 -n 0 -p $pid 2>/dev/null
done;

busybox echo "Renice Apps... = Activated..." | busybox tee -a $LS;

busybox echo "" | busybox tee -a $LS;
busybox echo "Optimization Renice System = Activated..." | busybox tee -a $LS
busybox echo "" | busybox tee -a $LS;
busybox echo "# END AmazBoost : $( date +"%m-%d-%Y %H:%M:%S" ) " | busybox tee -a $LS