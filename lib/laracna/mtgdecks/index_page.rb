require 'nokogiri'
require 'open-uri'

module Laracna
  module Mtgdecks
    class IndexPage
      def initialize(page, config)
        @config = config
        list_decks_url = @config.list_decks_url(page.to_s)

        @document = Nokogiri::HTML open(list_decks_url)
      end

      def deck_nodes
        @document
          .search("tr td a")
          .map { |node| node.attribute("href").text }
      end

      def decks_ids
        deck_nodes
          .map {|url| url.gsub(@config.deck_url, "")}
          .map(&:to_i)
          .delete_if {|i| i == 0} #for some delete weirds ids
      end
    end
  end
end
