require 'spec_helper'

describe SearchesController do
  context "respond in json" do
    context "without params" do
      before { get :top_cards, format: :json }
      subject { response }

      it { is_expected.to be_success }
      its(:content_type) { is_expected.to eq "application/json" }

      context "search results" do
        subject { assigns :top_cards }

        it { is_expected.to be_a ActiveRecord::Relation }
      end
    end

    context "with params" do
      let(:query) { "arbitrary query" }

      it "pass params to Orthanc" do
        expect(Orthanc).to receive(:new).with(query).and_return double.as_null_object

        get :top_cards, format: :json, query: query
      end
    end
  end
end
