#!/usr/local/bin/fish
#
# A script to launch nikto and compile the results
# Author: Daniel Pagan

echo ===========================
echo "Running nikto scan plugin"
echo ===========================

docker pull frapsoft/nikto
for port in $port_list
	echo "docker run frapsoft/nikto -host $target -port $port 2>&1 | tee $outdir/nikto-$port.txt"
	docker run frapsoft/nikto -host $target -port $port 2>&1 | tee $outdir/nikto-$port.txt
end

echo ===== nikto scan plugin ======
