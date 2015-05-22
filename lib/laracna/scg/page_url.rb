module Laracna
  module Scg
    class PageUrl
      HOST = "http://sales.starcitygames.com/"
      DECK_LIST_URL = "/deckdatabase/deckshow.php?&t%5BC1%5D=1&start_date=01/01/2015&end_date=03/22/2015&limit=100&order_1=date+desc&order_2=date+desc"
      PAGINATION_PARAM = "&start_num="
      DECK_URL = "/deckdatabase/displaydeck.php?DeckID="

      def self.list_decks_url(page = 1)
        HOST + DECK_LIST_URL + PAGINATION_PARAM + (page.to_i*100).to_s
      end

      def self.deck_url(deck_id)
        HOST + DECK_URL + deck_id.to_s
      end
    end
  end
end
