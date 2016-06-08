require "spec_helper"

describe "list page", type: :feature do
  before(:all) { create :inventory }

  context "with javascript", js: true do
    before { visit "/users/#{Inventory.first.user.id}/lists/#{Inventory.first.list}" }

    subject { page }

    it("list user collection") do
      is_expected.to have_css "div.card", count: 1
    end
  end
end
