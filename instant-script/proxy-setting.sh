#!/bin/bash

echo "Entering to /etc/apt directory"
cd /etc/apt

touch apt.conf
echo "Acquire::http::proxy \"http://10.129.200.61:3128\";" >> apt.conf
echo " Acquire::https::proxy \"https://10.129.200.61:3128\";" >> apt.conf
echo " Acquire::ftp::proxy \"ftp://10.129.200.61:3128\";" >> apt.conf
echo  "  Acquire::socks::proxy \"socks://10.129.200.61:3128\";" >> apt.conf

echo "apt.conf file is created"

cd 

echo "export https_proxy=\"https://10.129.200.61:3128\";" >>  ~/.bashrc
echo "export http_proxy=\"http://10.129.200.61:3128\";" >>  ~/.bashrc
echo "export ftp_proxy=\"ftp://10.129.200.61:3128\";" >>  ~/.bashrc


echo "entries are done"

