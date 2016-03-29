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
        main = @document.search("div .cards table")[0...-1]

        Hash[extract_card_list main]
      end

      def sideboard
        sideboard = @document.search("div .cards table")[-1]

        Hash[extract_card_list sideboard]
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
        nodes
          .search(".cardItem")
          .map(&:text)
          .map(&:strip)
          .map { |s| s.gsub(/\r|\t/,'') }
          .map { |s| s.split(/\n\n/)[0...-1].join(" ") }
          .map { |s| fix_typos s }
          .map { |s| s.match(/(\d+)(.*)/).captures.reverse.map(&:strip) }
      end

      def fix_typos(string)
        string
          .strip
          .gsub(/\t/," ")
          .gsub(/''/,"'")
          .gsub("  ","")
          .gsub("Unravel the Aether", "Unravel the Æther")
      end
    end
  end
end
