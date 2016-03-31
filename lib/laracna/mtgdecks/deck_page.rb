require "nokogiri"
require "open-uri"

module Laracna
  module Mtgdecks
    class DeckPage
      attr_reader :url, :document

      def initialize(url)
        @url = url

        remove_unused_elements
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
        main = engine.search("div .cards table")[0...-1]

        Hash[extract_card_list main]
      end

      def sideboard
        sideboard = engine.search("div .cards table")[-1]

        Hash[extract_card_list sideboard]
      end

      def attributes
        valid? ? deck_attributes : fail(InvalidPageError, @url)
      end

      def valid?
        main.keys.any?(&:empty?) || sideboard.keys.any?(&:empty?)
      end

      private

      def deck_attributes
        {
          description: description,
          name: name,
          list: {main: main, sideboard: sideboard},
          url: @url,
          source: "mtgdecks"
        }
      end

      def remove_unused_elements
        engine.search("h3").remove
        engine.search(".name").remove
      end

      def extract_card_list(nodes)
        nodes
          .search(".cardItem")
          .map(&:text)
          .map(&:strip)
          .map { |s| s.gsub(/\r|\t/, "") }
          .map { |s| s.split(/\n\n/)[0...-1].join(" ") }
          .map { |s| fix_typos s }
          .map { |s| break_entry(s) }
      end

      def break_entry(string)
        string.match(/(\d+)(.*)/).captures.reverse.map(&:strip)
      end

      def fix_typos(string)
        string
          .strip
          .gsub(/\t/, " ")
          .gsub(/''/, "'")
          .gsub("  ", "")
          .gsub("Unravel the Aether", "Unravel the Æther")
      end
    end
  end
end
