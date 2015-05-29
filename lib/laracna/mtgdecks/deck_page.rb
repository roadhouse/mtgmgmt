require 'nokogiri'
require 'open-uri'

module Laracna
  module Mtgdecks
    class DeckPage
      attr_reader :url, :document

      def initialize(id, config)
        @config = config
        @url = @config.complete_deck_url + id.to_s

        @document = Nokogiri::HTML(open(@url))

        remove_unused_elements
      end

      def description
        @document.search(".deckInfo strong").text
      end

      def name
        @document.search(".deckInfo strong")[0].text.split(".")[0]
      end

      def main
        main = @document.search(".md .cardItem")

        extract_card_list main
      end

      def sideboard
        sb = @document.search(".sb .cardItem")

        extract_card_list sb
      end

      def deck
        { main: main, sideboard: sideboard }
      end

      def attributes
        {
          description: description,
          name: name,
          card_list: deck,
          url: @url,
          source: "mtgdecks"
        }
      end

      private

      def remove_unused_elements
        @document.search("h3").remove
        @document.search(".name").remove
      end

      def extract_card_list(nodes)
        nodes.map(&:text).map { |i| fix_typos i }
          .map { |raw_part_entry| part_entry_data(raw_part_entry) }
      end

      def part_entry_data(raw_part_entry)
        match_data = /(\d+)(.*)/.match(raw_part_entry)

        {copies: match_data[1].strip, card: match_data[2].strip }
      end

      def fix_typos(string)
        string
          .strip
          .gsub(/\t/," ")
          .gsub(/''/,"'") 
          .gsub("Unravel the Aether", "Unravel the Æther")
      end
    end
  end
end
