require 'spec_helper'

describe GetAllFeeds do

  it 'has a version number' do
    expect(GetAllFeeds::VERSION).not_to be nil
  end

  it 'has a default number of items to be loaded' do
    expect(GetAllFeeds::DEFAULT_ITEM_COUNT).to eq 20
  end

  it 'has no items if no providers are specified' do
    expect(GetAllFeeds::fetch([])).to eq []
  end

  context "with providers" do
    it 'has no items if providers return nothing' do
      GetAllFeeds::InstagramFeed.any_instance.stub(:fetch_items).and_return([])
      expect(GetAllFeeds::fetch([:instagram])).to eq []
    end

    context "when unsuported provider" do
      it 'trows exception' do
        expect{
          GetAllFeeds::fetch([:abracadabra])
        }.to raise_error NameError
      end
    end

    context "with some data" do
      let(:social_item1) {
        GetAllFeeds::SocialItem.new(
          provider:   "instagram",
          identifier: 1,
          created_at: Date.today - 2,
          author:     "tester",
          body:       "description",
          thumbnail_url:  "http://example.com"
        )
      }
      let(:social_item2) {
        GetAllFeeds::SocialItem.new(
          provider:   "instagram",
          identifier: 222,
          created_at: Date.today - 1,
          author:     "tester",
          body:       "description",
          thumbnail_url:  "http://example.com"
        )
      }
      let(:social_item3) {
        GetAllFeeds::SocialItem.new(
          provider:   "instagram",
          identifier: 3123,
          created_at: Date.today,
          author:     "tester",
          body:       "description",
          thumbnail_url:  "http://example.com"
        )
      }

      it 'has no items if providers return nothing' do
        GetAllFeeds::InstagramFeed.any_instance.stub(:fetch_items).and_return([social_item1, social_item2, social_item3])
        expect(GetAllFeeds::fetch([:instagram])).to eq [social_item3, social_item2, social_item1]
      end
    end
  end
end
