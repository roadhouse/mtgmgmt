require 'nokogiri'
require 'open-uri'

module Laracna
  module DeckLists
    class IndexPage
      def initialize(page, config)
        @config = config
        list_decks_url = @config.list_decks_url(page.to_s)

        @document = Nokogiri::HTML(open(list_decks_url))
      end

      def decks_ids
        @document
          .search("table tr td a")
          .map {|node| node.attribute("href").text}
          .find_all {|node| node =~ /controller=deck/}
          .map {|url| url.gsub(@config.deck_url, "")}
          .map(&:to_i)
      end
    end
  end
end
