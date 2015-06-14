require 'spec_helper'

describe DeckParam do
  context "#params" do
    subject { described_class.new(filter_params).params }

    context "with season parameter = 'season'" do
      let(:filter_params) { {season: "season"} }

      its(:to_sql) { is_expected.to eq %{"decks"."season" = 'season'} }
    end

    context "without season parameter" do
      let(:filter_params) { {} }

      it { expect { subject }.to raise_error KeyError }
    end
  end

  context "#season_is('season')" do
    subject { described_class.new({}).season_is("season").to_sql }

    it { is_expected.to eq %{"decks"."season" = 'season'} }
  end
end
