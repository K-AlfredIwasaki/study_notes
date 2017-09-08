#!/usr/bin/python
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

# first we create tcount database
conn = psycopg2.connect(database="postgres", user="postgres", password="pass", host="localhost", port="5432")
conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
cur = conn.cursor()


# cleanup step - drop first before creating new database
cur.execute('DROP DATABASE IF EXISTS tcount')
conn.commit()


# create new database tcount
cur.execute('CREATE DATABASE tcount')
conn.commit()
cur.close()
conn.close()
print 'tcount is created now'

# connect to tcount database and create table Tweetwordcount
conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")
cur = conn.cursor()
cur.execute('''CREATE TABLE Tweetwordcount
       (word TEXT PRIMARY KEY     NOT NULL,
       count INT     NOT NULL);''')
conn.commit()
conn.close()
print 'table is created now'

