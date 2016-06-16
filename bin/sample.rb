#!/usr/bin/env ruby

require "bundler/setup"
require "get_all_feeds"

GetAllFeeds.configure do |c|
  c.social_item.count = 20
  c.twitter.consument_key = ''
  c.twitter.consumer_secret = ''
  c.twitter.access_token = ''
  c.twitter.access_token_secret = ''

  c.facebook.access_token = ''

  c.instagram.access_token = ''
end

GetAllFeeds.fetch([:instagram, :twitter, :facebook])
