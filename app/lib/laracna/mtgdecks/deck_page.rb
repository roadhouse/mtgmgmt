require "nokogiri"
require "open-uri"

module Laracna
  module Mtgdecks
    class DeckPage
      attr_reader :url, :document

      def initialize(url)
        @url = url
      end

      def engine
        @document ||= Nokogiri::HTML open @url
      end

      def config
        CrawlerConfig.new :mtgdecks
      end

      def description
        engine.search(".deckInfo strong").text
      end

      def name
        engine.search(".deckInfo strong")[0].text.split(".")[0]
      end

      def main
        card_list engine.search("div .cards table")[0...-1]
      end

      def sideboard
        card_list engine.search("div .cards table")[-1]
      end

      def attributes
        valid? ? deck_attributes : fail(InvalidPageError, @url)
      end

      def valid?
        main.keys.none?(&:empty?) && sideboard.keys.none?(&:empty?)
      end

      def source
        "mtgdecks"
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
        copies = nodes.search(".cardItem .number").map(&:text)
        cards = nodes.search(".cardItem td a").map(&:text)

        Hash[cards.zip copies]
      end
    end
  end
end
