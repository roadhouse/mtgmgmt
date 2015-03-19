require 'nokogiri'
require 'open-uri'

module Laracna
  module Mtgdecks
    class IndexPage
      def initialize(page)
        list_decks_url = PageUrl.list_decks_url(page.to_s)

        @document = Nokogiri::HTML(open(list_decks_url))
      end

      def decks_ids
        @document.search("tr strong a")
        .map {|node| node.attribute("href").text}
        .map {|url| url.gsub(PageUrl::DECK_URL, "")}
        .map(&:to_i)
      end
    end
  end
end
