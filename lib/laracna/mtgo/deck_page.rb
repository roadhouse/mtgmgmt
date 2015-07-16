require 'nokogiri'
require 'open-uri'

module Laracna
  module Mtgo
    class DeckPage
      class InvalidPageError < StandardError; end

      def initialize(url)
        @url = url
      end

      def engine
        @document ||= Nokogiri::HTML open(@url)
      end

      def decks_nodes
        engine.search(".deck-list-text")
      end

      def decks
        decks_nodes.map do |node|
          {
            main: build_hash(node.search(".sorted-by-overview-container .row")),
            sideboard: build_hash(node.search(".sorted-by-overview-sideboard .row"))
          }
        end
      end

      def build_hash(nodes)
        nodes.each_with_object({}) { |v,m| m[v.search(".card-name").text] = v.search(".card-count").text }
      end

      def deck
        { main: main, sideboard: sideboard }
      end

      def attributes
        {
          description: description,
          name: name,
          card_list: deck,
          url: url,
          source: "mtgo"
        }
      end
    end
  end
end
