require 'spec_helper'

describe SearchesController do
  context "respond in json" do
    before { get :top_cards, format: :json }
    subject { response }

    it { is_expected.to be_success }
    its(:content_type) { is_expected.to eq "application/json" }

    context "collection" do
      subject { assigns(:top_cards) }

      it { is_expected.to_not be_nil }
    end
  end
end
