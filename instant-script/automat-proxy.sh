#!/bin/bash

echo -n "DO u want change proxy settings [yes or no]:"

read yno
if [ yno==y ];
 then
	sudo mv /etc/apt/apt.conf /etc/apt/apt.conf-script
	

else
	echo "nothing"
	source ~/.bashrc
fi

function noproxy() 
{
	unset http_proxy
echo " Now u have no proxy "
}

noproxy
