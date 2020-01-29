#!/usr/local/bin/fish
#
# A plugin for plonkhonk to launch nikto and compile the results
# Author: Daniel Pagan

echo ===========================
echo "Running nikto scan plugin"
echo ===========================

# check for nikto
if not which nikto > /dev/null 2>&1
	echo "Error: nikto is either not installed or in the path"
else
	for port in $port_list
		echo "nikto -host $target -port $port -output $outdir/nikto-$port.txt"
		nikto -host $target -port $port -output $outdir/nikto-$port.txt
	end
end

echo ===== nikto scan complete ======
