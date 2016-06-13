require 'spec_helper'

describe DecksController, type: :controller do
  render_views

  before { sign_in create(:user) }

  context "GET on /cockatrice" do
    let(:deck) { create(:deck) }

    before { get :cockatrice, id: deck.id }

    context "response" do
      subject { response }

      it { is_expected.to be_successful }
    end
  end
end
