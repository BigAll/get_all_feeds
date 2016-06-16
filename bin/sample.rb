#!/usr/bin/env ruby

require "bundler/setup"
require "get_all_feeds"

GetAllFeeds.configure do |c|
  social_item.count = 20
  twitter.consument_key = ''
  twitter.consumer_secret = ''
  twitter.access_token = ''
  twitter.access_token_secret = ''

  facebook.access_token = ''

  instagram.access_token = ''
end

GetAllFeeds.fetch([:instagram, :twitter, :facebook])
