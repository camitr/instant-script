#!/bin/bash

## Calculate the column 3 value and store in variable 
myarr=($(awk -F "," '{
 Ip[$3]++;
 }
 END{
 for (var in Ip)
 print var,  Ip[var]
 }' 2))
echo ${myarr[2]}

## Insert query to push data in database 

for (( i = 0 ; i < ${#myarr[@]} ; i++ )) 
do
if [ $(($i % 2)) -eq 0 ]
then

   echo "INSERT INTO array (user,pages) VALUES ('${myarr[$i]}', '${myarr[$i+1]}');"
fi
done | mysql -u root -p123 printer	


