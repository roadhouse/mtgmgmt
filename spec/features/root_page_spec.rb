require "spec_helper"

describe "root page", type: :feature do
  before { create(:deck).list["main"].keys.map { |k| create :card, name: k } }

  context "without javascript" do
    it "works" do
      visit "/"
      expect(page).to have_content "welovemtg"
    end

    context 'with logged user' do
      before { login_as create(:user), scope: :user }

      it 'should log in' do
        visit "/"
        expect(page).to have_content "Sign out"
      end
    end
  end

  context "with javascript", js: true do
    before { visit "/" }

    subject { page }

    it("list top 12 cards") { is_expected.to have_css "div.card", count: 12 }

    context "livesearch" do
      before { fill_in "query[name]", with: "Dragon" }

      it "list the card with entered name" do
        is_expected.to have_css "div.card", count: 1
      end
    end
  end

  context 'with logged user', js: true do
    before { login_as create(:user), scope: :user }

    it 'should log in' do
      visit "/"
      expect(page).to have_content "Sign out"
    end
  end
end
