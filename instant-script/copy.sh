#!/bin/bash
# Bash script to filter out only question flv files of AAQ

for i in {1..130}
do
 
 cd Session\ $i 
echo "I am in session $i"
sudo rm Session*
cd ../
done 
