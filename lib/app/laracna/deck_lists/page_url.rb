module Laracna
  module DeckLists
    class PageUrl
      HOST = "http://www.decklists.net"
      DECK_LIST_URL = "/index.php?option=com_ohmydeckdb&controller=results&orderdir=desc&view=results&sformat[]=29&Itemid=&ordering=submitdate"
      PAGINATION_PARAM = "&page="
      DECK_URL = "/index.php?option=com_ohmydeckdb&controller=deck&view=deck&deckId="

      def self.list_decks_url(page = 1)
        HOST + DECK_LIST_URL + PAGINATION_PARAM + page.to_s
      end

      def self.deck_url(deck_id)
        HOST + DECK_URL + deck_id.to_s
      end
    end
  end
end
