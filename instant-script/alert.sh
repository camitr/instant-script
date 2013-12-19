#!/bin/bash

#This script gives an error message to user if the remote machine  is not in the network.
#The script use zenity.


export DISPLAY=:0  #It will enable gui display of alert message for the zenity
ping -c 10 10.129.200.61

	if [ $? -eq 0 ];
	then 
		echo "Network is UP $date">>server61_log
	else
		my=$(zenity --error --text="Network is Down") 

	fi

