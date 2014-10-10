#!/bin/bash

## access log detail 
awk '{print $1 "," $4 "," $2 "," $9 "," $10$11$12$13$14$15$16$17$18}' page_log.1|tr -d [] >2

## Add all the printer ###
cut -d "," -f1 2|sort -u > printer.csv

## Calculate Printer pages ###
 bash readme.sh > printerpages.csv

## Merging printer and its pages ###
paste -d "," printer.csv printerpages.csv > printerdata.csv

#######################################################################################################################

## Generate total user ###
awk -F "," '{print $3 "\t" $4  "\t" $1}' 2 > printloguser.csv 

## Calculating the unique user 
awk '!seen[$0]++' printloguser.csv > printuniqueuser1.csv

## Adding the comma between the comma ###
awk '{ $1=$1","; $(NF-1)=$(NF-1)","; print }' printuniqueuser1.csv > printuniqueuser.csv

## Calculate total page print ###
bash readme3.sh > pagesprint.csv

## Merging the user and its pages  
paste -d "," printuniqueuser.csv pagesprint.csv > userpages.csv

## Total pages

awk -F "," '{sum +=$4} END {print sum}' userpages.csv > Totalpages.csv

