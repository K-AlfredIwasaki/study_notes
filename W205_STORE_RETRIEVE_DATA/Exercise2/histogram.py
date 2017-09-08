#!/usr/bin/python
import sys

arg = sys.argv
arg.pop(0)

# created two integers k1,k2 and returns all the words with a total number of occurrences greater than or equal to k1, 
# and less than or equal to k2.

if len(arg) != 2:
    sys.exit('only two integers please')

try:
    k1 = int(arg[0])
    k2 = int(arg[1])
except ValueError:
    sys.exit('only accept integer please')

# check
if k1 > k2:
    sys.exit('valid interval please')

# connect to tcount
    
import psycopg2
conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")
cur = conn.cursor()
cur.execute('select word, count from tweetwordcount where count >= %s and count <= %s order by count desc', (k1, k2))
records = cur.fetchall()
for word in records:
    print '    %s: %d' %(word[0], word[1])

cur.close()
conn.close()
