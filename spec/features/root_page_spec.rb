require "spec_helper"

describe "root page", type: :feature do
  let(:deck) { create :deck }
  before { deck.list["main"].keys.map { |k| create :card, name: k } }
  before { deck.list["sideboard"].keys.map { |k| create(:card, name: k) unless Card.exists?(name: k) } }

  context "without javascript" do
    it "works" do
      visit "/"
      expect(page).to have_content "welovemtg"
    end
  end
end
