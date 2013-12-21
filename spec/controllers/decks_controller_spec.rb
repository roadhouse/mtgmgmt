require 'spec_helper'

describe DecksController do
  context "POST on /create" do

    before do
      ["magmajet","moutain","shock"].each { |c| create(:card, name: c) }

      post :create, deck: { name: "big red", description: "desc", card_list: "2 magmajet\r\n24 moutain\r\n\r\n3 shock\r\n" }
    end
    
    it("assigns a deck") { expect(assigns(:deck)).to_not be_nil }
  end
end
