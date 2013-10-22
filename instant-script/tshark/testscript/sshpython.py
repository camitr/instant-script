#!/usr/bin/python

import paramiko
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(
    paramiko.AutoAddPolicy())
ssh.connect('10.129.200.93', username='admin', 
    password='ttt23$')
stdin,stdout,stderr=\
ssh.exec_command("./BndwithAnalysis.sh")
type(stdin)
out=stdout.readlines()
print out
