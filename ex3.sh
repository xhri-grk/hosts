#!/bin/bash

cat /etc/hosts | while read -r ip name rest; do
	if [ "$ip" == "#" ]; then
		break
	fi
    	if [ -n "$name" ]; then
        	real_ip=`nslookup "$name" | head -5 | tail -1`
		real_ip="${real_ip:9}"
        	if [ "$real_ip" != "$ip" ]; then
        	    echo "Bogus IP for $name in /etc/hosts!"
        fi
    fi
done
