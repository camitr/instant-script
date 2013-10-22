#!/usr/bin/python

import MySQLdb as mdb

conn=mdb.connect(host='10.129.200.80',user='root',passwd='123',db='bndwidth') 
cur=conn.cursor()
cur.execute("select * from Analysis")
rows=cur.fetchall()

for row in rows:
	print row
