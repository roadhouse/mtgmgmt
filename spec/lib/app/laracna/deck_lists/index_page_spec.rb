require "./spec/support/vcr"

require "./lib/app/laracna/deck_lists/index_page"
require "./lib/app/laracna/deck_lists/page_url"

describe Laracna::DeckLists::IndexPage, :vcr do
  subject { Laracna::DeckLists::IndexPage.new(1) }

  its(:"decks_ids.size") { should == 20 }
end
