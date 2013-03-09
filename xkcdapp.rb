require 'sinatra'
require 'rufus/scheduler'

require './xkcdtweet.rb'

class XkcdApp < Sinatra::Base

    xkcd_tweets = XkcdTweet.new

    # Run manually
    get '/' do
        xkcd_tweets.tweet_latest
    end

    scheduler = Rufus::Scheduler.start_new

    scheduler.every '12h' do
        xkcd_tweets.tweet_latest
    end

end