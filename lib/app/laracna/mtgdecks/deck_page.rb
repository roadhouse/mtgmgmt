require 'nokogiri'
require 'open-uri'

module Laracna
  module Mtgdecks
    class DeckPage
      attr_reader :url, :document

      def initialize(id)
        @url = PageUrl.deck_url(id)

        @document = Nokogiri::HTML(open(@url))

        remove_unused_elements
      end

      def description
        @document.search(".deckHeader div strong").text
      end

      def name
        @document.search(".deckHeader .breadcrumb strong").text
      end

      def date
        Date.parse @document.search(".rightBlock ul li")[4].text
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
        (main + [""] + sideboard).join("\r\n")
      end

      def attributes
        {
          description: description,
          name: name,
          date: date,
          card_list: deck,
          url: @url
        }
      end

      private

      def remove_unused_elements
        @document.search("h3").remove
        @document.search(".name").remove
      end

      def extract_card_list(nodes)
        nodes.map(&:text).map { |i| fix_typos i }
      end

      def fix_typos(string)
        string
          .strip
          .gsub(/\t/," ")
          .gsub(/''/,"'") 
      end
    end
  end
end
