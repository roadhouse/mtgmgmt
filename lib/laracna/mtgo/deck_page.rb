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
        engine.search(".deck-group")
      end

      def decks
        decks_nodes.map { |node| build_deck(node) }
      end

      def build_deck(node)
        deck = {
          main: build_hash(node.search(".sorted-by-overview-container .row")),
          sideboard: build_hash(node.search(".sorted-by-sideboard-container .row"))
        }

        name = node.search(".deck-meta h4").text
        description = node.search(".deck-meta h5").text.strip

        {
          description: description,
          name: name,
          list: deck,
          url: @url,
          source: "mtgo"
        }
      end

      def build_hash(nodes)
        nodes.each_with_object({}) do |node, list| 
          card_name = node.search(".card-name").text
          copies = node.search(".card-count").text.to_i
          
          list[card_name] = copies 
        end
      end
    end
  end
end
