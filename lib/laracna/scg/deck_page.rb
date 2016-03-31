require "nokogiri"
require "open-uri"
require "./lib/laracna/crawler"

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
        main = engine.search(".cards_col1 ul li").map(&:text)
        main << engine.search(".cards_col2 ul").first.search("li").map(&:text)

        Hash[extract_card_list main.flatten]
      end

      def sideboard
        sb = engine.search(".cards_col2 ul").last.search("li").map(&:text)

        Hash[extract_card_list sb]
      end

      def attributes
        valid? ? deck_attributes : fail(InvalidPageError, @url)
      end

      def valid?
        !engine.search(".cards_col1 ul li").empty?
      end

      private

      def deck_attributes
        {
          description: description,
          name: name,
          list: {main: main, sideboard: sideboard},
          url: @url,
          source: "starcitygames"
        }
      end

      def extract_card_list(nodes)
        nodes.map { |string| part_entry_data string }
      end

      def part_entry_data(string)
        string.match(/(\d+)(.*)/).captures.reverse.map { |s| fix_typos s }
      end

      def fix_typos(string)
        string
          .strip
          .gsub(/\t/, " ")
          .gsub(/''/, "'")
          .gsub("AEther", "Æther")
          .gsub("Aether", "Æther")
          .gsub("Hero Of Iroas", "Hero of Iroas")
      end
    end
  end
end
