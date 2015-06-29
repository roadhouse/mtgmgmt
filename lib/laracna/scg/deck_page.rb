require 'nokogiri'
require 'open-uri'

module Laracna
  module Scg
    class DeckPage
      class InvalidPageError < StandardError; end

      def initialize(id, old_config)
        @id = id
      end

      def engine
        @document ||= Nokogiri::HTML open(url)
      end

      def url
        config.complete_deck_url + @id.to_s
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
        main << engine.search(".cards_col2 ul[rel='#{@id}']").first.search("li").map(&:text)

        extract_card_list main.flatten
      end

      def sideboard
        sb = engine.search(".cards_col2 ul[rel='#{@id}']").last.search("li").map(&:text)

        extract_card_list sb
      end

      def deck
        { main: main, sideboard: sideboard }
      end

      def attributes
        valid? ? deck_attributes : raise(InvalidPageError)
      end

      def valid?
        !engine.search(".cards_col1 ul li").empty?
      end

      private

      def deck_attributes
        {
          description: description,
          name: name,
          card_list: deck,
          url: @url,
          source: "starcitygames"
        }
      end

      def extract_card_list(nodes)
        nodes.map { |raw_part_entry| part_entry_data(raw_part_entry) }
      end

      def part_entry_data(raw_part_entry)
        match_data = /(\d+)(.*)/.match(raw_part_entry)

        {copies: match_data[1].strip, card: fix_typos(match_data[2]) }
      end

      def fix_typos(string)
        string
          .strip
          .gsub(/\t/," ")
          .gsub(/''/,"'") 
          .gsub("AE", "Æ")
      end
    end
  end
end
