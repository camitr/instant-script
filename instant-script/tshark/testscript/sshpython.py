#!/usr/bin/python

import paramiko
hostname = raw_input('IP:')
#dur	= raw_input('duration:')
#username = raw_input('username:')
#print hostname
#print username
 
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(
    paramiko.AutoAddPolicy())
ssh.connect(hostname,username='admin',password='ttt23$')
print "Analysing the packets......."
stdin,stdout,stderr=\
ssh.exec_command("./BndwithAnalysis.sh")
type(stdin)
out=stdout.readlines()
print out
