#!/bin/bash

for i in {1..98}
do
 
 cd Session\ $i 
 touch 1
echo "I am in session $i"
sudo rm 1
cd ../
done 
