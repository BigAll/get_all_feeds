module GetAllFeeds
  class TwitterFeed

    def fetch_items(options = {})
      api.home_timeline(count: options[:count]).map do |tweet|
        obj = SocialItem.new(
          provider:   "twitter",
          identifier: tweet.id,
          created_at: tweet.created_at.to_date,
          author:     tweet.user.screen_name,
          body:       tweet.full_text
        )
        obj.thumbnail_url = tweet.media[0].media_url.to_s if tweet.media?
        obj
      end
    end

    def api
      Twitter::REST::Client.new do |config|
        config.consumer_key = GetAllFeeds.configuration.twitter.consument_key
        config.consumer_secret = GetAllFeeds.configuration.twitter.consumer_secret
        config.access_token = GetAllFeeds.configuration.twitter.access_token
        config.access_token_secret = GetAllFeeds.configuration.twitter.access_token_secret
      end
    end
  end
end
