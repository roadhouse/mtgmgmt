require 'spec_helper'

describe DecksController, type: :controller do
  render_views

  before { login_as create(:user), scope: :user }

  context "POST on /create" do
    let!(:card) { create(:card) }
    let(:copies) { 4 }
    before do
      post :create, format: :json, deck: { card.id => copies }
    end
  end

  context "GET on /cockatrice" do
    let(:deck) { create(:deck) }

    before { get :cockatrice, id: deck.id }

    context "response" do
      subject { response }

      it { is_expected.to be_successful }
    end
  end
end
