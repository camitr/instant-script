#!/bin/bash
	#echo "Your Bandwidth test is statrting.Please provide the time duration to run the test"
	#read timeduration
	mkdir Test$(date +%d%m%y_%H_%M)
 	cd Test$(date +%d%m%y_%H_%M)

	mkdir ClientUploadTest
	
	cd ClientUploadTest
ServerIp=10.129.200.120
HostIp=$(ip addr show eth0 | grep -o 'inet [0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+' | grep -o [0-9].*)
# tshark to capture the file 
   	tshark -i eth0 -a duration:300 host $ServerIp -w CapFileTest.pcap
# converting to .csv with desired fields   
	tshark -r CapFileTest.pcap -T fields -e ip.src -e frame.len -E separator=, -E occurrence=f>CapFileTestSrc.csv
# Deleting the server IP
	sed -n "/$ServerIp/!p" CapFileTestSrc.csv>CapFileTestClient.csv
# Generate Averaqge Packet per second by calcluate total packets transmit in time
#	cat CapFileTestClient.csv | cut -d ',' -f 2 | paste -d   - > ClinetFLen.csv
   
	echo `cat CapFileTestClient.csv | cut -d ','  -f 2 | paste -sd+| bc`/`cat CapFileTestClient.csv|wc -l` | bc -l>AvgPacketSize.csv

#  	awk '{sum +=$1} END {print sum / NR}' ClinetFLen.csv>AvgPacketSize.csv
# Generate total packets tranmitted by client. 
  
 	awk 'END {print NR}' CapFileTestClient.csv >TotalClientPacket.csv
# Generate Average Packet size
	awk '{avgPckt=$1/300} {print avgPckt}' TotalClientPacket.csv>AvgPacketSec.csv
# Generate Upload bandwidth of client
  	cat AvgPacketSize.csv|awk '{n=$1;getline<"AvgPacketSec.csv";print (n*$1/1024)*8}'>BwdthKbps.csv
# For Download Bandwidth	
	
	mkdir ../ClientDownLoadTest
	cp CapFileTestSrc.csv ../ClientDownLoadTest
	cd ../ClientDownLoadTest
	sed -n "/$HostIp/!p" CapFileTestSrc.csv>CapFileTestClient.csv 
	echo `cat CapFileTestClient.csv | cut -d ','  -f 2 | paste -sd+| bc`/`cat CapFileTestClient.csv|wc -l` | bc -l>AvgPacketSizeDown.csv

	awk 'END {print NR}' CapFileTestClient.csv >TotalClientPacketDown.csv
	awk '{avgPckt=$1/300} {print avgPckt}' TotalClientPacketDown.csv>AvgPacketSecDown.csv
	cat AvgPacketSizeDown.csv|awk '{n=$1;getline<"AvgPacketSecDown.csv";print (n*$1/1024)*8}'>BwdthKbpsDown.csv
