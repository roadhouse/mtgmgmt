module Laracna
  module Mtgdecks
    class PageUrl
      HOST = "http://www.mtgdecks.net"
      DECK_LIST_URL = "/decks/viewByFormat/34/"
      PAGINATION_PARAM = "page:"
      DECK_URL = "/decks/view/"

      def self.list_decks_url(page = 1)
        HOST + DECK_LIST_URL + PAGINATION_PARAM + page.to_s
      end

      def self.deck_url(deck_id)
        HOST + DECK_URL + deck_id.to_s
      end
    end
  end
end
