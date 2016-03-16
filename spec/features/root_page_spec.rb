require 'spec_helper'

describe "root page", type: :feature do
  it "works" do
    visit '/'
    expect(page).to have_content "welovemtg"
  end
end
