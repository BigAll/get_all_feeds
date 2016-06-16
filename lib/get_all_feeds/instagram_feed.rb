module GetAllFeeds
  class InstagramFeed

    def fetch_items(options = {})
      api.user_recent_media(nil, count: options[:count]).map do |media|
        SocialItem.new(
          provider:   "instagram",
          identifier: media[:id],
          created_at: Time.at(media[:created_time].to_i).to_date,
          author:     media[:caption][:from][:full_name],
          body:       media[:caption][:text],
          thumbnail_url:  media[:images][:thumbnail][:url]
        )
      end
    end

    private

    def api
      Instagram.client(:access_token => GetAllFeeds.configuration.instagram.access_token)
    end

  end
end
