require 'spec_helper'

describe CardsController, type: :controller do
  context "GET /index" do
    before { get :index }
    subject { response }

    context "respond in json" do
      before { get :index, format: :json }
      subject { response }

      its(:status) { is_expected.to eq 200 }
      its(:content_type) { is_expected.to eq "application/json" }
    end
  end
end
