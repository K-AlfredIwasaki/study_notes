import re
import tweepy
import csv
from tweepy import OAuthHandler
from tweepy import Cursor

"""
- create a class and functions as followings
- clean
- get_sentiment score
- get_tweets
- write_tweets_to_csv
"""

class TwitterClient(object):

    def __init__(self):
        consumer_key = 'EHk0Go74jzlXwaM2bBQ3zjcOV'
        consumer_secret = 'YKW12QuKflLSk4K1nH1IWxxB3AkS7DxJNd11RsaxVegY5unm38'

        self.auth = OAuthHandler(consumer_key, consumer_secret)
        self.api = tweepy.API(self.auth)

    def get_tweets(self, id):
        tweets = []  # store tweets in this list

        try:
            #fetched_tweets = self.api.user_timeline(id=id, count=count)
            cursor = tweepy.Cursor(self.api.user_timeline, id=id, count=200)

            for page in cursor.pages(30):
                for tweet in page:
                    parsed_tweet = {}
                    parsed_tweet['twitterID'] = id
                    parsed_tweet['text'] = tweet.text.encode('utf-8')
                    parsed_tweet['sentiment'] = self.get_sentiment_score(tweet.text)
                    parsed_tweet['retweet_count'] = tweet.retweet_count
                    parsed_tweet['favorite_count'] = tweet.favorite_count
                    parsed_tweet['created_at'] = tweet.created_at

                    # avoid double-counting
                    if tweet.retweet_count > 0:
                        if parsed_tweet not in tweets:
                            tweets.append(parsed_tweet)
                    else:
                        tweets.append(parsed_tweet)
            return tweets

        except tweepy.TweepError as e:
            print("Error : " + str(e))

    def clean(self, tweet): # remove http//...
        return re.sub(r'^https?:\/\/.*[\r\n]*', '', tweet, flags=re.MULTILINE)

    def get_sentiment_score(self, tweet):

        goodWords = []
        with open('positiveWords.txt', 'r') as txtfile:
            for word in txtfile:
                goodWords.append(word[:-1])

        badWords = []
        with open('negativeWords.txt', 'r') as txtfile:
            for word in txtfile:
                badWords.append(word[:-1])

        sentiment_score = 0

        tweet = self.clean(tweet)

        for word in tweet.split():
            if word.lower() in goodWords:
                sentiment_score += 1
            elif word.lower() in badWords:
                sentiment_score += -1

        return sentiment_score

    def write_tweets_to_csv(self, tweets):
        keys = tweets[0].keys()
        with open('tweets.csv', 'wb') as output_file:
            dict_writer = csv.DictWriter(output_file, keys)
            dict_writer.writeheader()
            dict_writer.writerows(tweets)

# define main function

def main():
    api = TwitterClient() # create the class
    tweets = api.get_tweets(id='@ArianaGrande')
    tweets = tweets + api.get_tweets(id='@GiGiHadid')
    tweets = tweets + api.get_tweets(id='@jessicaalba')
    tweets = tweets + api.get_tweets(id='@KedallJenner')
    tweets = tweets + api.get_tweets(id='@halleberry')
    tweets = tweets + api.get_tweets(id='@katyperry')
    tweets = tweets + api.get_tweets(id='@blakelively') # doesn't tweet frequently
    tweets = tweets + api.get_tweets(id='@gagamonster96')
    tweets = tweets + api.get_tweets(id='@Beyonce') # doesn't tweet frequently
    tweets = tweets + api.get_tweets(id='@taylorswift13')
    tweets = tweets + api.get_tweets(id='@KimKardashian')
    tweets = tweets + api.get_tweets(id='@KingJames')
    tweets = tweets + api.get_tweets(id='@EmmaWatson')
    tweets = tweets + api.get_tweets(id='@EmmaStoneWeb')

    ptweets = [tweet for tweet in tweets if tweet['sentiment'] > 0]
    print("Positive tweets percentage: {} %".format(100 * len(ptweets) / len(tweets)))
    ntweets = [tweet for tweet in tweets if tweet['sentiment'] < 0]
    print("Negative tweets percentage: {} %".format(100 * len(ntweets) / len(tweets)))

    print("\nPositive tweets:")
    for tweet in ptweets[:5]:
        print(tweet['text'])

    api.write_tweets_to_csv(tweets)

# execute the function

if __name__ == "__main__":
    main()