#!/bin/bash

OIFS="$IFS"
IFS=$'\n'

path=$(lsblk |awk 'END {print $7}')

echo $path
	for each in `find $path `  ; do du -h --max-depth=0 --time $each | tr -s '[:blank:]' ',' ;done|sort -dr
		``

