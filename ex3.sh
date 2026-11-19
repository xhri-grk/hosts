#!/bin/bash

dns="8.8.8.8"

verify() {
	real_ip=`nslookup "$2" "$3" | head -6 | tail -1`
    	real_ip="${real_ip:9}"
	if [ "$2" == "localhost" ]; then
		if [ "$1" != "127.0.0.1" ]; then
	                echo "Bogus IP for $2 in /etc/hosts!"
		fi
	elif [ "$2" == "vlad-Aspire-AG15-72P" ]; then
		if [ "$1" != "127.0.1.1" ]; then
			echo "Bogus IP for $2 in /etc/hosts!"
		fi
    	elif [ "$real_ip" != "$1" ]; then
        	echo "Bogus IP for $2 in /etc/hosts!"
    	fi
}

cat /etc/hosts | while read -r ip name rest; do
	if [ "$ip" == "#" ]; then
		exit 0
	fi
    	if [ -n "$name" ]; then
		verify "$ip" "$name" "$dns"
    	fi
done
