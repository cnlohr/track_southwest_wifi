#!/bin/bash

HOST_TO_PING=google.com

while(true); do
	PINGRESP=$(ping -D -n -c 1 ${HOST_TO_PING} | grep icmp_seq | cut -d' ' -f 1,5-)
	CURRENTINFO=$(curl -s http://getconnected.southwestwifi.com/current.json | jq -r "[ .lat, .lon, .altVal] | @csv" | sed 's/\"//g' )
	TIMESTAMP=$(echo ${PINGRESP} | cut -d' ' -f1 | sed 's/]//g' | sed 's/\[//g' )
	PINGTIME=$(echo ${PINGRESP} | awk -F 'time=' '{print $2}' )
	echo ${TIMESTAMP},${PINGTIME},${CURRENTINFO}
	sleep 1 # Don't turbo time it.
done

