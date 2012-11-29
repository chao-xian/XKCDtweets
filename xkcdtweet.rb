require 'rubygems'
require 'feedzirra'
require 'twitter'

class XkcdTweet

    # Get latest XKCD
    def tweet_latest
        xkcd_feed = Feedzirra::Feed.fetch_and_parse('http://xkcd.com/atom.xml')
        xkcd_latest = xkcd_feed.entries.first

        # Get latest tweet
        tweet = Twitter.user_timeline("XKCDtweets").first

        puts xkcd_latest.updated

        puts tweet.created_at

        Twitter.update("TEST")

        if xkcd_latest.updated.to_date > tweet.created_at.to_date then
            puts "New comic"
            Twitter.update(xkcd_latest.title + " " + xkcd_latest.url)
        end

        puts "Tweeted"
    end

end