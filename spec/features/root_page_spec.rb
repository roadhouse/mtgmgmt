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

    xcontext 'with logged user' do
      before { login_as create(:user), scope: :user }

      it 'should log in' do
        visit "/"
        expect(page).to have_content "Sign out"
        expect(page).not_to have_content "Sign in"
      end
    end
  end

  context "with javascript", js: true do
    before { visit "/" }

    subject { page }

    xit("list top 12 cards") { is_expected.to have_css "div.card", count: 12 }

    context "livesearch" do
      before { fill_in "query[name]", with: "Dragon" }

      xit "list the card with entered name" do
        is_expected.to have_css "div.card", count: 1
      end
    end
  end

  xcontext 'with logged user', js: true do
    before { login_as create(:user), scope: :user }

    it 'should log in' do
      visit "/"
      expect(page).to have_content "Sign out"
      expect(page).not_to have_content "Sign in"
    end

    xit 'add cart to user list' do
      visit '/'
      find('div .collapsible-header').click
      find('div .secondary-content', text: 'Plains').click
    end
  end
end
