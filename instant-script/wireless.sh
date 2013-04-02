#!/bin/sh

	 ping -c 4  10.102.152.111 > /dev/null && echo "IP is up"

if [ $? -eq 0 ];
then

		echo "wireless is up $(date '+%d-%b-%y %T') ">>/opt/wireless.log
else 

		echo "wireless not working $(date '+%d-%b-%y %T') ">>/opt/wireless.log

 		/opt/lampp/bin/php /opt/lampp/htdocs/wireless/email/email.php


fi

touch /tmp/amit
echo "i am out of if">>count.txt

count=$( wc -l wireless.log|cut -d ' ' -f 1 ) 
echo $count>>count.txt
echo $count>/tmp/count.txt
if [ $count -gt 100 ]
then 
echo "insdie if">>count.txt
sed -i '1,500d' wireless.log
echo "sed executed">>wireless.log
fi 

echo "i m outside if">>count.txt


