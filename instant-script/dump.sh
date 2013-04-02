#!/bin/sh
# Script take the back for 3 databases 1.Courses 2.aaqportal 3.forum
# and backup of web contain of cov cov1 and ask excludeing the videos contain 
# then transer the file to 10.129.200.61 server at location /root/database-backup-62server

echo "*****************Dump for Mysql started************************"
/opt/lampp/bin/mysqldump -u root -proot  courses>/root/database-dump/courses.sql
/opt/lampp/bin/mysqldump -u root -proot  aaqportal>/root/database-dump/aaqportal.sql
/opt/lampp/bin/mysqldump -u root -proot  forum>/root/database-dump/forum.sql
/opt/lampp/bin/mysqldump -u root -proot  researchportal>/root/database-dump/researchportal.sql
/opt/lampp/bin/mysqldump -u root -proot  newforum>/root/database-dump/newforum.sql #database backup for new forum

cd /root/database-dump
# tar file is created and resync sql file to 61 machine 
tar -zcvf backupsql_$(date +%d%m%y).tgz *.sql
echo " !!!!!!!!!!!!!!!!!!!!!!!!! Dump is completed Thanks for the support !!!!!!!!!!!!!!!!!!"

echo "********************Transefering the Mysql backup file to 10.129.200.61 Server****************"
ping -c2 10.129.200.61
if [ $? -eq 0 ];
then
	rsync -av /root/database-dump/*.tgz backup-61@10.129.200.61:/home/backup-61/database-backup-62server

	echo "backup taken on $(date)">>/root/database-dump/dump.log
else
	echo "backup failed on $(date)">>/root/database-dump/dump.log
fi


rm backupsql*.tgz
rm *.sql
echo "!!!!! Transefer is completed !!!!!!!"
#Directory is change to /htdocs and create tar file and rsync to 61 machine
echo "************Transefering webcontain to server***********************"
cd /opt/lampp/htdocs
tar  -zcvf backupweb_$(date +%d%m%y).tgz --exclude='videos' ask cov --exclude='content' research forum footer QAT session_display aaq_display 
rsync -av /opt/lampp/htdocs/*.tgz backup-61@10.129.200.61:/home/backup-61/database-backup-62server
rm backupweb*.tgz
#It will ssh to 61 machine and check the file older than 5 days using 
#find command and delete the if exits.
ssh backup-61@10.129.200.61 "cd /home/backup-61/database-backup-62server ;  
find /home/backup-61/database-backup-62server/* -mtime +4 -exec rm {} \;|while read line; do


echo "output of find result='$line'"
done"


echo "!!!!!!!!!!!!!!!!! Webcontain Transefer is completed !!!!!!!!!!!!!!!!!!" 
/opt/lampp/bin/php /opt/lampp/htdocs/email/email.php
echo "Mail is sent"
