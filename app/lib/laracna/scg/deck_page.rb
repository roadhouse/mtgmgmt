require "nokogiri"
require "open-uri"
require "./app/lib/laracna/crawler"

module Laracna
  module Scg
    class DeckPage
      def initialize(url)
        @url = url
      end

      def engine
        @document ||= Nokogiri::HTML open @url
      end

      def config
        CrawlerConfig.new(:scg)
      end

      def description
        engine.search(".deck_played_placed").text.strip
      end

      def name
        engine.search(".deck_title").text.strip
      end

      def main
        selector = ".deck_card_wrapper > div:not(.deck_sideboard) > ul > li"

        card_list engine.search(selector).map(&:text)
      end

      def sideboard
        card_list engine.search(".deck_sideboard > ul > li").map(&:text)
      end

      def attributes
        valid? ? deck_attributes : fail(InvalidPageError, @url)
      end

      def valid?
        !engine.search(".cards_col1 ul li").empty?
      end

      def source
        "starcitygames"
      end

      private

      def deck_attributes
        {
          description: description,
          name: name,
          list: {main: main, sideboard: sideboard},
          url: @url,
          source: source
        }
      end

      def card_list(nodes)
        deck_list = nodes
                    .map { |string| fix_typos string }
                    .map { |string| string.match(/(\d+) (.*)/).captures.reverse }

        Hash[deck_list]
      end

      def fix_typos(string)
        string
          .strip
          .gsub(/''/, "'")
          .gsub("AEther", "Æther")
          .gsub("Aether", "Æther")
      end
    end
  end
end
