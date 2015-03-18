require 'nokogiri'
require 'open-uri'

module Laracna
  module Scg
    class IndexPage
      def initialize(page)
        list_decks_url = PageUrl.list_decks_url(page.to_s)
        binding.pry

        @document = Nokogiri::HTML(open(list_decks_url))
      end

      def deck_nodes
        @document.search(".deckdbbody2 a")
          .map {|node| node.attribute("href").text}
          .delete_if {|c|c.match("deckshow")}
      end

      def decks_ids
        deck_nodes
          .map {|url| url.gsub(PageUrl::DECK_URL, "")}
          .map(&:to_i)
          .delete_if {|i| i == 0} #for some delete weirds ids
      end
    end
  end
end
