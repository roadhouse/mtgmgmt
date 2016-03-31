require "nokogiri"
require "open-uri"

module Laracna
  module Mtgo
    class IndexPage
      def initialize(page)
        @document = Nokogiri::HTML open page
      end

      def decks_ids
        @document.search("tr strong a")
          .map { |node| node.attribute("href").text }
          .map { |url| url.gsub(PageUrl::DECK_URL, "") }
          .map(&:to_i)
      end
    end
  end
end
