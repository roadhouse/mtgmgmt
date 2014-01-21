require "./spec/support/vcr"

require "./lib/app/laracna/mtgdecks/index_page"
require "./lib/app/laracna/mtgdecks/page_url"

describe Laracna::Mtgdecks::IndexPage, :vcr do
  subject { Laracna::Mtgdecks::IndexPage.new(1) }

  its(:"decks_ids.size") { should == 20 }
end
