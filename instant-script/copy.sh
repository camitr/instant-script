#!/bin/bash
# Bash script to filter out only question flv files of AAQ

echo "Type start number of session"
read startn
echo "Type end number of session"
read end

for i in {50..89}
do
 
 cd Session\ $i 
echo "I am in session $i"
sudo rm Session*
cd ../
done 
