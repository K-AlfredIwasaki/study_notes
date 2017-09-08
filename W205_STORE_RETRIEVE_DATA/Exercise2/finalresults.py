#!/usr/bin/python
import sys

arg = sys.argv
arg.pop(0)

# add some resctrictions on the word length and varaibles 

if len(arg) > 1:
    sys.exit('No more than 1 variable')

# connect to tcount

import psycopg2
conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")
cur = conn.cursor()

# when passed a single word as argument:

if len(arg) == 1:
    cur.execute('select count from tweetwordcount where word = %s', (arg[0].lower(),))
    rtn = cur.fetchone()
    print 'Total number of occurences of "%s": %s' %(arg[0].lower(), '0' if not rtn else str(rtn[0]))

# running without an argument returns all the words in the stream, and their total count of occurrences, 
# sorted alphabetically, one word per line.

if len(arg) == 0:
    cur.execute('select * from Tweetwordcount order by word')
    words = cur.fetchall()
    for word in words:
        print '(%s, %s)' %(word[0], word[1])

cur.close()
conn.close()
