require "nokogiri"
require "open-uri"

module Laracna
  module Mtgo
    class IndexPage
      def initialize(page); end

      def date_range
        (DateTime.now.to_date..8.months.ago.to_date)
      end

      def config
        CrawlerConfig.new :mtgo
      end

      def decks_url
        URI.join config.host, config.deck_url
      end

      def urls
        date_range.map { |date| decks_url.concat date.strftime config.date_format }
      end
    end
  end
end
