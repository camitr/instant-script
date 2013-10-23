#!/bin/bash
	#echo "Your Bandwidth test is statrting.Please provide the time duration to run the test"
	#read timeduration
                    
mydate=$(date +%Y-%m-%d' '%H:%M:%S)
echo $mydate>date.csv
hostname>source.csv
 
# 	cd Test$(date +%d%m%y_%H_%M)

#	mkdir ClientUploadTest
	
echo "Time duration of the test in second"
read dur
ServerIp=10.129.200.120
HostIp=$(ip addr show eth0 | grep -o 'inet [0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+' | grep -o [0-9].*)
# tshark to capture the file 
   	tshark -i eth0 -a duration:$dur host $ServerIp -w CapFileTest.pcap
# converting to .csv with desired fields   
	tshark -r CapFileTest.pcap -T fields -e ip.src -e frame.len -E separator=, -E occurrence=f>CapFileTestSrc.csv
# Deleting the server IP
	sed -n "/$ServerIp/!p" CapFileTestSrc.csv>CapFileTestClient.csv
# Generate Averaqge Packet per second by calcluate total packets transmit in time
#	cat CapFileTestClient.csv | cut -d ',' -f 2 | paste -d   - > ClinetFLen.csv
   
	echo `cat CapFileTestClient.csv | cut -d ','  -f 2 | paste -sd+| bc`/`cat CapFileTestClient.csv|wc -l` | bc >AvgPacketSize.csv

#  	awk '{sum +=$1} END {print sum / NR}' ClinetFLen.csv>AvgPacketSize.csv
# Generate total packets tranmitted by client. 
  
 	awk 'END {print NR}' CapFileTestClient.csv >TotalClientPacket.csv
# Generate Average Packet size
	awk '{avgPckt=$1/'$dur'} {print avgPckt}' TotalClientPacket.csv>AvgPacketSec.csv
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
	awk '{avgPckt=$1/'$dur'} {print avgPckt}' TotalClientPacketDwn.csv>AvgPacketSecDwn.csv
	cat AvgPacketSizeDwn.csv|awk '{n=$1;getline<"AvgPacketSecDwn.csv";print (n*$1/1024)*8}'>BwdthKbpsDwn.csv
#merging different csv files

        paste -d ',' TotalClientPacketDwn.csv AvgPacketSecDwn.csv AvgPacketSizeDwn.csv BwdthKbpsDwn.csv >ClientDwn.csv
# Merging csv to obtain the final result
	paste -d ',' date.csv source.csv ClientUp.csv ClientDwn.csv >TestAnalysis.csv
# upload the data on mysql using python script
	python mysqlConnect.py

