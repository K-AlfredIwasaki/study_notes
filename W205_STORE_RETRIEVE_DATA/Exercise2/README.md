# w205-exercises2

### Step1. Set-up environment

- initiate Amazon EC2 instance by using the provided AMI
- start Postgres
- install pyscopg, tweepy
```
$ pip install psycopg2==2.6.2
$ pip install tweepy
```
### Step2. Get codes from the git repo
```
$ git clone https://github.com/K-AlfredIwasaki/w205-exercises2.git
```
### Step3. Create the database tcount and the table tweetwordcount

- change directory to extweetwordcount/src/bolts/
- run creatdatabase.py

### Step4. Test your twitter crendential

- insert your credentials in Twittercredentials.py (under the main folder) and tweets.py (under src/spouts)
```
$ python hello-stream-twitter.py
```

### Step5. Run the application

- move to extweetwordcount/
```
$ sparse run
```
- Ctrl + C to stop streaming once you collect enough data

- move to the main w205-exercises2 directory
```
$ python finalresults.py
```
and with specifc word:
```
$ python finalresults.py Your
```
This returns a count of "Your" in the twitter stream
```
$ python histogram.py 3 8
```
- histogram.py returns all the words with a total number of occurences between 3 and 8

### Step6. Check top 20 words in twitter stream by posgres
```
$ psql -U postgres
postgres=# \\c tcount
tcount=# SELECT * FROM tweetwordcount ORDER BY count DESC LIMIT 20;
```
