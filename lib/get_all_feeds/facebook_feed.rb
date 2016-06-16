module GetAllFeeds
  class FacebookFeed

    def fetch_items(options = {})
      api(options[:count]).data.map do |data|
        SocialItem.new(
          provider:   "facebook",
          identifier: data.id,
          created_at: Date.parse(data.created_time),
          author:     data.from.name,
          body:       data.description,
          thumbnail_url:  data.picture
        )
      end
    end

    private

    def api(count)
      MiniFB.get(GetAllFeeds.configuration.facebook.access_token, "me", {type: "feed", params: {limit: count}})
    end

  end
end
