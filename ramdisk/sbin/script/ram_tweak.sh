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

PMB=/sdcard/amazboost/LOGS/RAM_tweak.log

if [ -e $PMB ]; then
busybox	rm $PMB;
fi;

busybox touch $PMB;
busybox echo "# AmazBoost" | busybox tee -a $PMB;
busybox echo "" | busybox tee -a $PMB;
busybox echo "# STARTING UP AmazBoost : $( date +"%m-%d-%Y %H:%M:%S" )" | busybox tee -a $PMB;
busybox echo "" | busybox tee -a $PMB;

# LMK Moderate =========================================#

OLDADJ=`cat /sys/module/lowmemorykiller/parameters/adj`
busybox echo "Old ADJ Values: $OLDADJ" | busybox tee -a $PMB;
OLDMIN=`cat /sys/module/lowmemorykiller/parameters/minfree`
busybox echo "Old MINFREE Values: $OLDMIN" | busybox tee -a $PMB;
busybox echo "" | busybox tee -a $PMB;

# Minfree Values 

RAM=`free|grep Mem | awk '{print $2}'`;

busybox chmod 644 /sys/module/lowmemorykiller/parameters/minfree;
if [ "$RAM" -lt 512000 ];then
busybox echo "3072,6144,9216,14336,20480,25600" > /sys/module/lowmemorykiller/parameters/minfree;	
elif [ "$RAM" -lt 1024000 ];then
busybox	echo "6144,10240,12288,16384,20480,25600" > /sys/module/lowmemorykiller/parameters/minfree;
elif [ "$RAM" -lt 1536000 ];then
busybox	echo "8192,12288,14336,16384,20480,25600" > /sys/module/lowmemorykiller/parameters/minfree;
elif [ "$RAM" -lt 2048000 ];then
busybox echo "12288,15360,18432,21504,24576,30720" > /sys/module/lowmemorykiller/parameters/minfree;
else
busybox echo "16384,20480,24576,28672,32768,36884" > /sys/module/lowmemorykiller/parameters/minfree;  
fi;

# ADJ/COST Values

if [ -e /sys/module/lowmemorykiller/parameters/adj ] ; then
busybox chmod 644 /sys/module/lowmemorykiller/parameters/adj;
busybox echo "0,1,3,5,10,15" > /sys/module/lowmemorykiller/parameters/adj;
fi;	
if [ -e /sys/module/lowmemorykiller/parameters/cost ]; then
busybox chmod 644 /sys/module/lowmemorykiller/parameters/cost;
busybox echo "32" > /sys/module/lowmemorykiller/parameters/cost;
fi;

busybox sleep 1

NEWADJ=`cat /sys/module/lowmemorykiller/parameters/adj`
busybox echo "New ADJ Values: $NEWADJ" | busybox tee -a $PMB;
NEWMIN=`cat /sys/module/lowmemorykiller/parameters/minfree`
busybox echo "New MINFREE Values: $NEWMIN" | busybox tee -a $PMB;
busybox echo "" | busybox tee -a $PMB;
if [ /sys/module/lowmemorykiller/parameters/adj=0,1,3,5,10,15 ]; then
busybox echo "Optimization Moderate LMK = Activated..." | busybox tee -a $PMB; else
busybox echo "Optimization Moderate LMK = Not Activated..." | busybox tee -a $PMB;
fi;

busybox echo "" | busybox tee -a $PMB;
busybox echo "# END OF AmazBoost : $( date +"%m-%d-%Y %H:%M:%S" ) " | busybox tee -a $PMB