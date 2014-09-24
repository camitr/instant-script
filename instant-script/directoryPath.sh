#!/bin/bash
recurse() {
 for i in "$1"/*;do
     if [ -d "$i" ];then
             echo  "directory : $i "
	     cd $i
#	     echo "Present Working directory:"
		ls -lsh|awk 'NR <= 1 {next} {print $1 "\t" $7"."$8"."$9 "\t " $10}'
		printf "Total Size= $(du -sh| cut -f1)\n\n" 
#	     pwd
   	     cd -	>>/dev/null	

             recurse "$i"

         elif [ -f "$i" ]; then
	         echo "file: $i"
	     fi

      done
}

recurse $1 .
