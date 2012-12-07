require 'rubygems'
require 'feedzirra'
require 'twitter'
require 'rack/env'

class XkcdTweet

    # Get latest XKCD
    def tweet_latest

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