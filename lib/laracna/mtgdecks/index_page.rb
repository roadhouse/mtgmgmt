require "nokogiri"
require "open-uri"

module Laracna
  module Mtgdecks
    class IndexPage
      def initialize(page)
        list_decks_url = config.list_decks_url page.to_s

        @document = Nokogiri::HTML open list_decks_url
      end

      def config
        CrawlerConfig.new :mtgdecks
      end

      def deck_nodes
        @document
          .search("tr td a")
          .map { |node| node.attribute("href").text }
      end

      def decks_ids
        deck_nodes
          .map { |url| url.gsub(config.deck_url, "") }
          .map(&:to_i)
          .delete_if { |i| i == 0 } # delete some weirds ids
      end
    end
  end
end
