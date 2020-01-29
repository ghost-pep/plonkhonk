#!/usr/local/bin/fish
#
# A plugin for plonkhonk to launch wapiti3 and compile the results
# Author: Daniel Pagan

echo ===========================
echo "Running wapiti3 scan plugin"
echo ===========================

# check for wapiti3
if not which wapiti > /dev/null 2>&1
	echo "Error: wapiti3 is either not installed or in the path"
else
	for port in $port_list
		echo "wapiti -u $target:$port/ -f txt -o $outdir/wapiti-report-$port.txt 2>&1 | tee wapiti-runtime-$port.txt"
		wapiti -u $target:$port/ -f txt -o $outdir/wapiti-report-$port.txt 2>&1 | tee $outdir/wapiti-runtime-$port.txt
	end
end

echo ===== wapiti3 scan complete =====
