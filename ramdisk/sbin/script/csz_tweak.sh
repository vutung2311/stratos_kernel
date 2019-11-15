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

LS=/sdcard/amazboost/LOGS/CSZ_Tweaks.log

if [ -f $LS ]; then
rm $LS;
fi;

echo "#  CSZ Tweaks Log" | busybox tee -a $LS
echo "" | busybox tee -a $LS
echo "Tweaking Ram" | busybox tee -a $LS

setprop persist.sys.purgeable_assets 1
 
echo "Tweaking VM Values" | busybox tee -a $LS

setprop dalvik.vm.dexopt-data-only 1
setprop dalvik.vm.checkjni false
setprop dalvik.vm.execution-mode int:jit
setprop dalvik.vm.jmiopts forcecopy
setprop dalvik.vm.jniopts warnonly
setprop dalvik.vm.verify-bytecode false


echo "" | busybox tee -a $LS
echo "Better scrolling" | busybox tee -a $LS

setprop persist.sys.scrollingcache 3
