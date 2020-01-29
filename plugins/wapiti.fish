#!/usr/local/bin/fish
#
# A plugin for plonkhonk to launch wapiti3 and compile the results
# Author: Daniel Pagan

echo ===========================
echo "Running wapiti3 scan plugin"
echo ===========================

for port in $port_list
	echo "wapiti -u $target:$port/ -f txt -o $outdir/wapiti-report-$port.txt 2>&1 | tee wapiti-runtime-$port.txt"
	wapiti -u $target:$port/ -f txt -o $outdir/wapiti-report-$port.txt 2>&1 | tee $outdir/wapiti-runtime-$port.txt
end

echo ===== wapiti3 scan complete =====
