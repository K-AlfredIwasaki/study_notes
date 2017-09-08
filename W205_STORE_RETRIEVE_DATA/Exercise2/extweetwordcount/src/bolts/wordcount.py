from __future__ import absolute_import, print_function, unicode_literals

from collections import Counter
from streamparse.bolt import Bolt

import psycopg2

# creat the counter and connect it with tcount database

class WordCounter(Bolt):

    def initialize(self, conf, ctx):
        self.counts = Counter()
        self.conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")
        self.cur = self.conn.cursor()
        self.log('connect with tcount')
        self.cur.execute('SELECT * FROM Tweetwordcount')
        records = self.cur.fetchall()
        for rec in records:
            self.counts[rec[0]] = int(rec[1])
        self.conn.commit()
	self.log('connect with %d  word' %self.cur.rowcount)

    def process(self, tup):
        word = tup.values[0]

        # Write codes to increment the word count in Postgres
        # Use psycopg to interact with Postgres


        # Increment the local count 
        self.counts[word] += 1
        self.emit([word, self.counts[word]])

	if self.counts[word] == 1:
            self.cur.execute("INSERT INTO Tweetwordcount (word, count) VALUES (%s, 1)", (word,))
        else:
            self.cur.execute("UPDATE Tweetwordcount SET count=%s WHERE word=%s", (self.counts[word], word))
        self.conn.commit()

        # Log the count - just to see the topology run
        self.log('%s: %d' % (word, self.counts[word]))
