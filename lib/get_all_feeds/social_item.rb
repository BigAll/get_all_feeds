module GetAllFeeds
  class SocialItem
    attr_accessor :provider, :identifier, :created_at, :author, :body, :thumbnail_url

    def initialize(params = {})
      params.each { |attr, value| send "#{attr}=", value }
    end

    def created_at=(value)
      raise Exception.new("created_at should be of type Date") if !value.instance_of?(Date)
      @created_at = value
    end
  end
end
