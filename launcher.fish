#!/usr/bin/env fish
#
# A fish shell script to automate web application penetration testing
# Author: Daniel Pagan

# ===== globals =====
set max_args 4
set outdir "./results"
set port_list 80
set seclistdir "$HOME/SecLists"

# ===== functions =====
function usage
	echo "Usage:" (status filename) "<target name or IP>" "<plugin to run>" "-o <optional results dir>" "-p <optional port>" "-w <optional SecListsDir>"
end

# ===== entry point =====
# test for args
if test (count $argv) -le 0 -o (count $argv) -gt $max_args
	usage
	exit
end

# set args
if test (count $argv) -ge 3
	# parse args out
	# there also has to be a better way to deal with this in fish....
	set outflag 0
	for arg in $argv
		if test "$arg" = "-o"
			set outflag 1
		end
		if test $outflag
			set outdir $arg
			set outflag 0
		end
	end
end


# check for an IP addr or a hostname
set target $argv[1]
set ip $argv[1]

# set plugin to run
set plugin $argv[2]

set regexp_ip '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])'
if not echo $target | grep -oqE $regexp_ip
	# perform a lookup for the hostname
	set ip (nslookup google.com | grep Server | cut -f 3)
end

echo "Hostname:" $target
echo "IP addr:" $ip

# create results directory
if test ! -e $outdir -o ! -d $outdir
	mkdir $outdir
end

# launch
set_color green
echo Plugin: $plugin
set_color normal
source $plugin
# plugins have target, ip, outdir, port_list
