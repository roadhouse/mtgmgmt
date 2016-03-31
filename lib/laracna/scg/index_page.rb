require "nokogiri"
require "open-uri"

module Laracna
  module Scg
    class IndexPage
      def initialize(page)
        @page = page

        @document = Nokogiri::HTML open list_decks_url
      end

      def config
        CrawlerConfig.new :scg
      end

      def list_decks_url
        config.list_decks_url page @page.to_s
      end

      def page(page)
        ((page.to_i - 1) * 100).to_s
      end

      def deck_nodes
        @document
          .search("td[class^=deckdbbod] a")
          .map { |node| node.attribute("href").text }
          .delete_if { |c| c.match "deckshow" }
      end

      def decks_ids
        deck_nodes
          .map { |url| url.gsub(config.complete_deck_url, "") }
          .map(&:to_i)
          .delete_if { |i| i == 0 } # for some delete weirds ids
      end
    end
  end
end
