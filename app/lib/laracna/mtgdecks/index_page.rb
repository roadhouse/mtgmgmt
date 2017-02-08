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

      def urls
        @document
          .search("tr td a")
          .map { |node| URI.join(config.host, node.attribute("href").text) }
      end
    end
  end
end
