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

LS=/sdcard/amazboost/LOGS/IO_tweaks.log

busybox rm -f $LS
busybox touch $LS

echo "# AmazBoost LOGGING ENGINE" | busybox busybox tee -a $LS
echo "" | busybox busybox tee -a $LS
echo "$( date +"%m-%d-%Y %H:%M:%S" ) Applying I/O Tweaks..." | busybox busybox tee -a $LS;

MMC=`ls -d /sys/block/mmc*`;
RAM=`ls -d /sys/block/ram*`;
LOOP=`ls -d /sys/block/loop*`;


# Tweak non-rotating storage; 
for i in $MMC $RAM $LOOP;
do

	if [ -e $i/queue/rotational ]; 
	then
		echo 0 > $i/queue/rotational; 
	fi;
	if [ -e $i/queue/nr_requests ];
	then
		echo 8192 > $i/queue/nr_requests; 
	fi;
	if [ -e $i/queue/iosched/fifo_batch ]; then
echo "1" > $i/queue/iosched/fifo_batch
fi;

if [ -e $i/queue/iosched/writes_starved ]; then
echo "1" > $i/queue/iosched/writes_starved
fi;
	
if [ -e $i/queue/nomerges ]; then
echo "0" > $i/queue/nomerges
fi;	
done
	
	
#  Tweak readahead; 
		echo "256" >  /sys/devices/platform/jzmmc_v1.2.0/mmc_host/mmc0/mmc0:0001/block/mmcblk0/queue/read_ahead_kb;
	
#  reduce overhead (disable iostats)
	if [ -e $i/queue/iostats ];
	then
		echo "0" > $i/queue/iostats;
	fi;	

	
L=256

MMMC=/sys/block/mmc*
for S in $MMMC;
do
	if [ -f $S/queue/read_ahead_kb ];
	then
		busybox echo "$L" > $S/queue/read_ahead_kb;
	fi;
	if [ -f $S/bdi/read_ahead_kb ];
        then
              busybox echo "$L" > $S/bdi/read_ahead_kb;
        fi;
done

echo "" | busybox busybox tee -a $LS
echo "$( date +"%m-%d-%Y %H:%M:%S" ) SDCard and I/O tweaking done!" | busybox busybox tee -a $LS;
