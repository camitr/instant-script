#!/bin/bash
if [ -d "$1" ]
	then 
		search=$1
		echo "name of directory is $1 and it exists "
		cd $1
 		
		echo  "type the name of directory to create "
		read name 
			mkdir $name 
	else
		echo "Directory not found"
fi
