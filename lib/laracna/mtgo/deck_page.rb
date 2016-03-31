require "nokogiri"
require "open-uri"

module Laracna
  module Mtgo
    class DeckPage
      def initialize(url)
        @url = url
      end

      def engine
        @document ||= Nokogiri::HTML open @url
      end

      def decks_nodes
        engine.search ".deck-group"
      end

      def decks
        decks_nodes.map { |node| build_deck node }
      end

      def deck(node)
        {
          main: build_hash(node.search(".sorted-by-overview-container .row")),
          sideboard: build_hash(node.search(".sorted-by-sideboard-container .row"))
        }
      end

      def name(node)
        node.search(".deck-meta h4").text
      end

      def description(node)
        node.search(".deck-meta h5").text.strip
      end

      def build_deck(node)
        {
          description: description(node),
          name: name(node),
          list: deck(node),
          url: @url + "#" + name(node).gsub(/(\(|\)|\s)/, ""),
          source: "mtgo"
        }
      end

      def build_hash(nodes)
        nodes.each_with_object({}) do |node, list|
          card_name = node.search(".card-name").text.gsub("Aether", "Æther")
          copies = node.search(".card-count").text.to_i

          list[card_name] = copies
        end
      end
    end
  end
end
