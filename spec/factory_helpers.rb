module FactoryHelpers
  extend self

  def page_content
    tags = ["a", "h1", "h2", "h3"]
    url_index_content = { h1: [], h2: [], h3: [], a: [] }
    doc  = Nokogiri::HTML(FFaker::HTMLIpsum.body)
    doc.css(*tags).map do |node|
      case node.name
        when "a"
          url_index_content[:a] << node.attributes["href"].value
        when "h1", "h2", "h3"
          url_index_content[node.name.to_sym] << node.text
      end
    end
    url_index_content
  end
end