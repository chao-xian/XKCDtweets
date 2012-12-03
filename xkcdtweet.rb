require 'rubygems'
require 'feedzirra'
require 'twitter'
require 'rack/env'

class XkcdTweet

    # Get latest XKCD
    def tweet_latest

        Twitter.configure do |config|
          config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
          config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
          config.oauth_token = ENV['TWITTER_OAUTH_TOKEN']
          config.oauth_token_secret = ENV['TWITTER_OAUTH_TOKEN_SECRET']
        end

        # Get latest xkcd
        xkcd_feed = Feedzirra::Feed.fetch_and_parse('http://xkcd.com/atom.xml')
        xkcd_latest = xkcd_feed.entries.first

        # Get last tweet on my timeline
        tweet = Twitter.user_timeline("XKCDtweets").first

        # If the xkcd is more recent, post it to my timeline
        if xkcd_latest.updated.to_date > tweet.created_at.to_date then
            Twitter.update(xkcd_latest.title + " " + xkcd_latest.url)
        end

    end

end