require "spec_helper"

describe "root page", type: :feature do
  it "works" do
    visit "/users/1/lists/want"
    expect(page).to have_content "welovemtg"
  end
end

