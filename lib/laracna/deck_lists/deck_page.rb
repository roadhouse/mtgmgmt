require 'nokogiri'
require 'open-uri'

module Laracna
  module DeckLists
    class DeckPage
      attr_reader :url

      def initialize(id)
        @url = PageUrl.deck_url(id)

        @document = Nokogiri::HTML(open(@url))

        remove_unused_elements
      end

      def description
        @document.search(".eventInfo").text
      end

      def name
        @document.search("h1").first.text
      end

      def date
        Date.parse @document.search(".OhMyDecklistDate").text
          .gsub("on ", "")
      end

      def main
        main = @document.search(".OhMyDecklistTableView tr").last
          .search("td").first
          .search("li")

        extract_card_list main
      end

      def sideboard
        sb = @document.search(".OhMyDecklistTableView tr").last
          .search("td").last
          .search("li")

        extract_card_list sb
      end

      def deck
        { main: main, sideboard: sideboard }
      end

      def attributes
        {
          description: description,
          name: name,
          date: date,
          card_list: deck,
          url: @url,
          source: "decklists"
        }
      end

      private

      def remove_unused_elements
        @document.search(".imagetd").remove
        @document.search(".title").remove
        @document.search(".cardCount").remove
      end

      def extract_card_list(nodes)
        nodes.map(&:text).map { |i| fix_typos i }
          .map { |i| i.match(/(\d*) (.*)/).captures }
          .map { |i| {copies: i[0], card: i[1]} }
      end

      def fix_typos(text)
        text.gsub(/^(\d*)x/,"\\1")
        .gsub("Æ","Ae")
      end
    end
  end
end
