require 'spec_helper'

describe DecksController, type: :controller do
  render_views

  context "POST on /create" do 
    let!(:card) { create(:card) }
    let(:copies) { 4 }
    before do
      post :create, format: :json, deck: { card.id => copies }
    end

    context "response" do
      subject { response }

      it { is_expected.to be_successful }
      its(:content_type) { is_expected.to eq "application/json" }

      context "json data" do
        let(:deck_list) { [{"copies" => copies, "name" => card.name, "id" => card.id}] }

        subject { OpenStruct.new JSON.parse(response.body) }

        its(:deck_list) { is_expected.to eq deck_list }
      end
    end
  end
end
