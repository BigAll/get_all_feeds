require "twitter"
require "instagram"
require "mini_fb"
require "configurations"
require "active_support/inflector"
require "get_all_feeds/version"
require "get_all_feeds/social_item"
require "get_all_feeds/twitter_feed"
require "get_all_feeds/instagram_feed"
require "get_all_feeds/facebook_feed"

module GetAllFeeds
  include Configurations

  DEFAULT_ITEM_COUNT = 20

  def fetch(providers)
    items = providers.map do |provider|
      feed_provider = "#{provider}_feed"
      "GetAllFeeds::#{feed_provider.camelize}".constantize.new.fetch_items(count: item_count)
    end.flatten.compact

    items.sort_by{ |a| a.created_at }.reverse
  end

  private

  def item_count
    GetAllFeeds.configuration&.social_item&.count || DEFAULT_ITEM_COUNT
  end


  module_function :item_count, :fetch
end
