#!/bin/bash 

## sed to replace  and modify the date
#sed -i 's/\//-/g' 2
sed -i 's/Jan\|January/01/gi;s/Feb\|February/02/gi;s/Mar\|March/03/gi;s/Apr\|April/04/gi;s/May\|May/05/gi;s/Jun\|June/06/gi;s/Jul\|July/07/gi;s/Aug\|August/08/gi;s/Sep\|September/09/gi;s/Oct\|October/10/gi;s/Nov\|November/11/gi;s/Dec\|December/12/gi' 2
sed -i 's/\///g' 2
sed -i 's/:/ /' 2


## Reading log file and store in array and push it in database

while IFS=, read -ra arr; do


dat=$(date -d ${arr[1]:0:9} +'%Y-%m-%d')
dat=$(echo $dat ${arr[1]:10})
	    echo "INSERT INTO print_detail (printer,date,user,IP,info) VALUES ('${arr[0]}','$dat','${arr[2]}','${arr[3]}', '${arr[4]}');"

done < 2 | mysql -uroot -p123 printer 
