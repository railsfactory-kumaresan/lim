require 'rails_helper'

RSpec.describe CrawlerList, type: :model do
  it { should validate_presence_of(:url) }

  it "is not valid without a url" do
    expect(CrawlerList.new(url: nil)).to_not be_valid
  end
  it "is valid with valid attributes" do
    expect(CrawlerList.new(url: FFaker::Internet.http_url )).to be_valid
  end

  describe ".parse_url_content" do
    it "should parse the url with given default content" do
      result = described_class.parse_url_content("http://guides.rubyonrails.org/testing.html")
      result[:h1].first == 'Guides.rubyonrails.org'
    end
    it "should respond as Invalid URL" do
      result = described_class.parse_url_content(FFaker::Internet.http_url)
      result == 'Invalid URL'
    end
  end
end
