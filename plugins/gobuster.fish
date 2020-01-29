#!/usr/local/bin/fish
#
# A plugin for plonkhonk to launch gobuster and compile the results
# Author: Daniel Pagan

echo ===========================
echo "Running gobuster scan plugin"
echo ===========================

# check for gobuster
if not which gobuster > /dev/null 2>&1
	echo "Error: gobuster is either not installed or in the path"
else
	for port in $port_list
		echo "gobuster dir -u $target -w $seclistdir/Discovery/Web-Content/common.txt -o $outdir/gobuster-$port.txt"
		gobuster dir -u $target -w $seclistdir/Discovery/Web-Content/common.txt -o $outdir/gobuster-$port.txt
	end
end

echo ===== gobuster scan complete =====
