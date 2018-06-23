require 'spec_helper'

describe DecksController, type: :controller do
  render_views

  context "GET on /cockatrice" do
    let(:deck) { create(:deck) }

    before { get :cockatrice, params: {id: deck.id }}

    context "response" do
      subject { response }

      it { is_expected.to be_successful }
    end
  end
end
