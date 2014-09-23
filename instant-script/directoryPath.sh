#!/bin/bash
recurse() {
 for i in "$1"/*;do
     if [ -d "$i" ];then
             echo  "directory : $i "
#	     cd $i
#	     echo "Present Working directory:"
#	     pwd
 #  	     cd -		

             recurse "$i"

         elif [ -f "$i" ]; then
	         echo "file: $i"
	     fi

      done
}

recurse $1 
