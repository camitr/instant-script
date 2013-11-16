#!/bin/bash
	#echo "Your Bandwidth test is statrting.Please provide the time duration to run the test"
	#read timeduration
                    
mydate=$(date +%Y-%m-%d' '%H:%M:%S)
echo ","$mydate >date.csv
hostname>source.csv
 
# 	cd Test$(date +%d%m%y_%H_%M)

#	mkdir ClientUploadTest
	
ServerIp=10.129.200.120
HostIp=$(ip addr show eth0 | grep -o 'inet [0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+' | grep -o [0-9].*)
# tshark to capture the file 
   	tshark -i eth0 -a duration:1 host $ServerIp -w CapFileTest.pcap
# converting to .csv with desired fields   
	tshark -r CapFileTest.pcap -T fields -e ip.src -e frame.len -E separator=, -E occurrence=f>CapFileTestSrc.csv
	tshark -r CapFileTest.pcap -T fields -e frame.len -E separator=, -E occurrence=f>length.csv
# Deleting the server IP
	sed -n "/$ServerIp/!p" CapFileTestSrc.csv>CapFileTestClient.csv
# calculating Average packet size   
	echo `cat CapFileTestClient.csv | cut -d ','  -f 2 | paste -sd+| bc`/`cat CapFileTestClient.csv|wc -l` | bc >AvgPacketSize.csv

# Generate total packets tranmitted by client. 
  
 	awk 'END {print NR}' CapFileTestClient.csv >TotalClientPacket.csv
# Generate Average Packet sec
	awk '{avgPckt=$1/1} {print avgPckt}' TotalClientPacket.csv>AvgPacketSec.csv
# Generate Upload bandwidth of client
  	cat AvgPacketSize.csv|awk '{n=$1;getline<"AvgPacketSec.csv";print (n*$1/1024)*8}'>BwdthKbps.csv
# Merging the Upload files 
 paste -d ',' TotalClientPacket.csv AvgPacketSec.csv AvgPacketSize.csv BwdthKbps.csv >ClientUp.csv
# For Download Bandwidth	
	
	#mkdir ../ClientDownLoadTest
	cp CapFileTestSrc.csv CapFileTestDwn.csv
	#cd ../ClientDownLoadTest
	sed -n "/$HostIp/!p" CapFileTestDwn.csv>CapFileTestClientDwn.csv 
	echo `cat CapFileTestClientDwn.csv | cut -d ','  -f 2 | paste -sd+| bc`/`cat CapFileTestClientDwn.csv|wc -l` | bc>AvgPacketSizeDwn.csv

	awk 'END {print NR}' CapFileTestClientDwn.csv >TotalClientPacketDwn.csv
	awk '{avgPckt=$1/1} {print avgPckt}' TotalClientPacketDwn.csv>AvgPacketSecDwn.csv
	cat AvgPacketSizeDwn.csv|awk '{n=$1;getline<"AvgPacketSecDwn.csv";print (n*$1/1024)*8}'>BwdthKbpsDwn.csv
#merging different csv files

        paste -d ',' TotalClientPacketDwn.csv AvgPacketSecDwn.csv AvgPacketSizeDwn.csv BwdthKbpsDwn.csv >ClientDwn.csv
# Merging csv to obtain the final result
	paste -d ',' date.csv source.csv ClientUp.csv ClientDwn.csv >TestAnalysis.csv
# upload the data on mysql using python script

#TotalCapPacket=`cat TotalClientPacket.csv`
TotalCapPacket=$(wc -l<length.csv)

awk '{ if ($1 >= 40 && $1 <= 79) print $1 }' length.csv>40-79.csv
total=$(wc -l<40-79.csv)
echo "scale=4;($total / $TotalCapPacket) * 100"|bc -l>>Pecentage.csv

awk '{ if ($1 >= 80 && $1 <= 159) print $1 }' length.csv>80-159.csv
total=$(wc -l<80-159.csv)
echo "scale=4;($total / $TotalCapPacket) * 100"|bc -l>>Pecentage.csv

awk '{ if ($1 >= 160 && $1 <= 319) print $1 }' length.csv>160-319.csv
total=$(wc -l<160-319.csv)
echo "scale=4;($total / $TotalCapPacket) * 100"|bc -l>>Pecentage.csv

awk '{ if ($1 >= 320 && $1 <= 639) print $1 }' length.csv>320-639.csv
total=$(wc -l<320-639.csv)
echo "scale=4;$total / $TotalCapPacket) * 100"|bc -l>>Pecentage.csv

awk '{ if ($1 >= 640 && $1 <= 1279) print $1 }' length.csv>640-1279.csv
total=$(wc -l<640-1279.csv)
echo "scale=4;($total / $TotalCapPacket) * 100"|bc -l>>Pecentage.csv

awk '{ if ($1 >= 1280 && $1 <= 2559) print $1 }' length.csv>1280-2559.csv
total=$(wc -l<1280-2559.csv)
echo "scale=4;($total / $TotalCapPacket) * 100"|bc -l>>Pecentage.csv

awk '{ if ($1 >= 2560 && $1 <= 5119) print $1 }' length.csv>2560-5119.csv
total=$(wc -l<2560-5119.csv)
echo "scale=4;($total / $TotalCapPacket) * 100"|bc -l>>Pecentage.csv


#paste -d ',' source.csv>Percentage.csv
awk '{printf("%s,", $0)}' Pecentage.csv>Percentage.csv
#To add a machine name  in starting of line 
sed -i 's/^/,amit,/' Percentage.csv
rm -rf Pecentage.csv

	python mysqlConnect.py
#rm -rf Percentage.csv
