require 'spec_helper'

describe SearchesController do
  render_views

  let!(:card) { create(:card) }

  context "GET /index.json" do
    before { allow(Orthanc).to receive(:new).and_return double(top_cards: Card.all) }

    context "response body" do
      before { get :top_cards, format: :json }
      subject { JSON.parse response.body }

      it { is_expected.to be_a Array }
      it { is_expected.to all have_key("id") }
      it { is_expected.to all have_key("name") }
      it { is_expected.to all have_key("ctype") }
      it { is_expected.to all have_key("portuguese_name") }
      it { is_expected.to all have_key("price") }
      it { is_expected.to all have_key("image") }
    end
  end
end
