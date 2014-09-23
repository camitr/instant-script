#!/bin/bash

export DISPLAY=:0
ping -c 10 10.129.200.61 >>/dev/null

	if [ $? -eq 0 ];
	then 
		echo "Network is UP $(date)">>server61_log
	else
		my=$(zenity --error --text="Network is Down") 
		echo "Network Down $(date)">>server61_log
	fi

currentTime=$(date "+%H%M")

	if [ "$currentTime" -gt "1110"  -a "$currentTime" -lt "1230" ]; 
	then 
		sed -i '1,10d' server61_log
		echo "file clear"

	fi

