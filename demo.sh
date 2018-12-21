#!/bin/bash

i="0"

while [ $i -lt 200 ]; do
	IP=$(curl -s checkip.amazonaws.com)    
	echo $IP
    	sleep 15
    	i=$[$i+1]
done
