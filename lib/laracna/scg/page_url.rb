module Laracna
  module Scg
    class PageUrl
      HOST = "http://sales.starcitygames.com/"
      DECK_LIST_URL = "/deckdatabase/deckshow.php?&t%5BC1%5D=1&start_date=12/28/2014&end_date=03/22/2015&limit=100"
      PAGINATION_PARAM = "&start_num="
      DECK_URL = "http://sales.starcitygames.com//deckdatabase/displaydeck.php?DeckID="

      def self.list_decks_url(page = 1)
        HOST + DECK_LIST_URL + PAGINATION_PARAM + (page.to_i*100).to_s
      end

      def self.deck_url(deck_id)
        HOST + DECK_URL + deck_id.to_s
      end
    end
  end
end
