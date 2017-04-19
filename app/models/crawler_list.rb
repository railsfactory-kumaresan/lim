require 'open-uri'
class CrawlerList < ApplicationRecord
  validates_presence_of :url
  validates :url, url: true

  DEFAULT_TAGS = ["a", "h1", "h2", "h3"]

  def self.index_and_save params
    page = where(url: params[:url]).first
    if page.present?
      page.update_attributes(content: parse_url_content(page.url))
    else
      page = create(url: params[:url], content: parse_url_content(params[:url]))
    end
    page.errors.blank? ? [ parse_json(page), 200] : [ page.errors.full_messages,422]
  end

  def self.parse_url_content url
    content = { h1: [], h2: [], h3: [], a: [] }
    begin
      doc  = Nokogiri::HTML(open(url))
      doc.css(*DEFAULT_TAGS).map do |node|
        case node.name
          when "a"
            content[:a] << node.attributes["href"].value
          when "h1", "h2", "h3"
            content[node.name.to_sym] << node.text
        end
      end
      content
    rescue => e
      'Invalid URL'
    end
  end

  def self.parse_json page
    {
      url: page.url,
      content: {
        a: JSON.parse(page.content["a"]),
        h1: JSON.parse(page.content["h1"]),
        h2: JSON.parse(page.content["h2"]),
        h3: JSON.parse(page.content["h3"])
      }
    }
  end
end
