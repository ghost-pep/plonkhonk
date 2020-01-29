#!/usr/local/bin/fish
#
# A plugin for plonkhonk to launch gobuster and compile the results
# Author: Daniel Pagan

echo ===========================
echo "Running gobuster scan plugin"
echo ===========================

for port in $port_list
	echo "gobuster dir -u $target -w $seclistdir/Discovery/Web-Content/common.txt -o $outdir/gobuster-$port.txt"
	gobuster dir -u $target -w $seclistdir/Discovery/Web-Content/common.txt -o $outdir/gobuster-$port.txt
end

echo ===== gobuster scan complete =====
