#!/usr/local/bin/fish
#
# A plugin for plonkhonk to launch nikto and compile the results
# Author: Daniel Pagan

echo ===========================
echo "Running nikto scan plugin"
echo ===========================

# check for nikto
if which nikto
	echo "Error: nikto is either not installed or in the path"
end

for port in $port_list
	echo "nikto -host $target -port $port -output $outdir/nikto-$port.txt"
	nikto -host $target -port $port -output $outdir/nikto-$port.txt
end

echo ===== nikto scan plugin ======
