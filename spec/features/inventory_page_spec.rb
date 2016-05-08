require "spec_helper"

describe "root page", type: :feature do
  let(:user) { create :user}
  before { user }

  it "works" do
    visit "/users/#{user.id}/lists/want"
    expect(page).to have_content "welovemtg"
  end

  it "respond in JSON" do
    # visit "/users/#{user.id}/lists/want.json"
    # expect(page).to have_content "welovemtg"
  end
end

